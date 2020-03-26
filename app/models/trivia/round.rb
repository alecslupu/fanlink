# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  status           :integer          default("draft"), not null
#  complexity       :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  start_date       :integer
#  end_date         :integer
#  product_id       :integer          not null
#

module Trivia
  class Round < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id, counter_cache: :round_count

    has_many :questions, -> { order("question_order") }, class_name: "Trivia::Question", foreign_key: :trivia_round_id, dependent: :destroy
    has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    validates :start_date, presence: true, if: -> { locked? || published? || running? }
    validate :avalaible_questions_status_check, on: :update, if: -> { published? }
    validates_numericality_of :start_date, greater_than_or_equal_to: Proc.new { Time.zone.now.to_i }, if: -> { published? }
    validate :start_date_type, if: -> { published? }
    validates :status, changing_attributes: true, on: :update, if: -> { published? }

    include AASM

    enum status: {
      draft: 0,
      published: 1,
      locked: 2,
      running: 3,
      closed: 4,
    }

    aasm(column: :status, enum: true, whiny_transitions: false, whiny_persistence: false, logger: Rails.logger) do
      state :draft, initial: true
      state :published
      state :locked
      state :running
      state :closed

      event :publish do
        transitions from: :draft, to: :published
      end

      event :unpublish do
        transitions from: :published, to: :draft
      end

      event :locked do
        transitions from: :published, to: :locked
      end
      event :running do
        transitions from: :locked, to: :running
      end

      event :closed do
        transitions from: :running, to: :closed
      end
    end

    def copy_to_new
      new_entry = dup
      new_entry.update!(status: :draft, start_date: nil, end_date: nil )
      new_entry.questions = questions.collect(&:copy_to_new)
      self.class.reset_counters(id, :questions, touch: true)
      self.class.reset_counters(new_entry.id, :questions, touch: true)
      new_entry
    end

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status)
    end

    scope :visible, -> { where(status: [:published, :locked, :running, :closed]) }

    def compute_leaderboard
      return unless closed?
      begin
        self.class.connection.execute("select compute_trivia_round_leaderboard(#{id})")
      rescue ActiveRecord::StatementInvalid
        self.class.round_leaderboard
        self.class.connection.execute("select compute_trivia_round_leaderboard(#{id})")
      end
    end

    def self.round_leaderboard
      self.connection.execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_round_leaderboard(round_id integer)
RETURNS void AS $$
  BEGIN
    INSERT INTO trivia_round_leaderboards (trivia_round_id, points, position, person_id, average_time, created_at, updated_at, product_id )
    SELECT
      trivia_round_id,
      CASE
        WHEN points >= 0 THEN points
        ELSE 0
      END,
      position,
      person_id,
      average_time,
      NOW() AS created_at,
      NOW() as updated_at,
      product_id
    FROM (
      SELECT
        q.trivia_round_id,
        r.complexity * ( r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY AVG(a.time))) as points,
        ROW_NUMBER () OVER (ORDER BY SUM(l.points) DESC,AVG(a.time)) as position,
        a.person_id,
        AVG(a.time) as average_time,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        INNER JOIN trivia_question_leaderboards l ON (l.trivia_question_id = a.trivia_question_id)
      WHERE q.trivia_round_id  = $1 AND a.is_correct = 't'
      GROUP BY q.trivia_round_id,r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard
    ON CONFLICT (trivia_round_id ,person_id)
    DO UPDATE SET points = excluded.points, position = excluded.position, average_time = excluded.average_time;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "round", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;
)
    end


    def compute_gameplay_parameters
      date_to_set = start_date
      questions.each_with_index do |question, index|
        question.start_date = date_to_set
        question.set_order(1 + index)
        question.compute_gameplay_parameters
        date_to_set = question.end_date_with_cooldown
      end
      self.end_date = questions.reload.last.end_date
      save
    end

    def end_date_with_cooldown
      end_date
    end

    # administrate fallback
    def game_id
      trivia_game_id
    end

    private
      def avalaible_questions_status_check
        questions.map(&:available_question).each do |available_question|
          if !available_question.published?
            errors.add(:base, "All available questions used must have 'published' status before publishing")
            break
          end
        end
      end

      def start_date_type
        if start_date.present?
          errors.add(:start_date, "must be an integer") unless start_date.integer?
        end
      end
  end
end
