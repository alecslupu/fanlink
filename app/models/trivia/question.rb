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
      self.class.connection.execute("select compute_trivia_question_leaderboard(#{id})")
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

    private

      def add_question_type
        question_type = available_question.type.sub("Available", "")
        self.type = question_type
      end
  end
end

