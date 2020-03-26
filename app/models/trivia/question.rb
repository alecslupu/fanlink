# == Schema Information
#
# Table name: trivia_questions
#
#  id                    :bigint(8)        not null, primary key
#  trivia_round_id       :bigint(8)
#  time_limit            :integer
#  type                  :string
#  question_order        :integer          default(1), not null
#  cooldown_period       :integer          default(5)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  start_date            :integer
#  end_date              :integer
#  available_question_id :integer
#  product_id            :integer          not null
#

module Trivia
  class Question < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :round, class_name: "Trivia::Round", counter_cache: :question_count, foreign_key: :trivia_round_id
    belongs_to :available_question, class_name: "Trivia::AvailableQuestion",  dependent: :destroy
    has_many :leaderboards, class_name: "Trivia::QuestionLeaderboard", foreign_key: :trivia_question_id, dependent: :destroy
    has_many :trivia_answers, class_name: "Trivia::Answer", foreign_key: :trivia_question_id, dependent: :destroy
    has_many :available_answers, through: :available_question, source: :available_answers


    validates :time_limit, numericality: {greater_than: 0},
              presence: true

    validates :cooldown_period, numericality: {greater_than: 5},
              presence: true

    validates :type, inclusion: {in: %w(Trivia::SingleChoiceQuestion
                Trivia::MultipleChoiceQuestion Trivia::PictureQuestion
                Trivia::BooleanChoiceQuestion Trivia::HangmanQuestion
              ),  message: "%{value} is not a valid type"}

    validates :available_question, presence: {message: "Please make sure selected question type is the compatible with available question type"}

    before_validation :add_question_type, on: :create


    def compute_leaderboard
      # raise "retry" if Time.zone.now < end_date
      begin
        self.class.connection.execute("select compute_trivia_question_leaderboard(#{id})")
      rescue ActiveRecord::StatementInvalid
        self.class.question_leaderboard
        self.class.connection.execute("select compute_trivia_question_leaderboard(#{id})")
      end
    end

    def self.question_leaderboard
      self.connection.execute %Q(
    CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
      RETURNS void AS $$
      BEGIN
        -- Select the questions in round
        INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at, product_id )
        SELECT
        MAX(trivia_question_id) trivia_question_id,
        MAX(CASE
        WHEN points >= 0 THEN points
        ELSE 0
        END) points,
          person_id,
        NOW() AS created_at,
                 NOW() as updated_at,
                          MAX(product_id) product_id
        FROM (
               SELECT
        q.id as trivia_question_id,
                r.complexity * (r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY a.time)) as points,
                                                                                              a.person_id,
                                                                                              q.product_id
        FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        WHERE q.id  = $1 AND a.is_correct = 't'
        ) AS leaderboard
        GROUP BY person_id
        ORDER by points desc
        ON CONFLICT (trivia_question_id ,person_id)
        DO UPDATE SET points = excluded.points;
        PERFORM pg_notify('leaderboard',  CONCAT('{"type": "question", "id": ', $1 ,'}'));
        END;
        $$
        LANGUAGE plpgsql;
        )
    end
    # administrate falback
    def round_id
      trivia_round_id
    end

    def compute_gameplay_parameters
      self.end_date = self.start_date + self.time_limit
      self.save!
    end

    def end_date_with_cooldown
      self.end_date + self.cooldown_period.seconds
    end

    def set_order(index)
      self.question_order = index
      self.save
    end

    def copy_to_new
      new_entry = dup
      new_entry.update!(start_date: nil, end_date: nil)
      new_entry
    end

    private

      def add_question_type
        question_type = available_question.type.sub("Available", "")
        self.type = question_type
      end
  end
end

