# == Schema Information
#
# Table name: trivia_questions
#
#  id                    :bigint(8)        not null, primary key
#  trivia_round_id       :bigint(8)
#  type                  :string
#  question_order        :integer          default(1), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  start_date            :integer
#  end_date              :integer
#  time_limit            :integer
#  cooldown_period       :integer          default(5)
#  available_question_id :integer
#

module Trivia
  class Question < ApplicationRecord
    has_paper_trail
    belongs_to :round, class_name: "Trivia::Round", counter_cache: :question_count, foreign_key: :trivia_round_id
    belongs_to :available_question, class_name: "Trivia::AvailableQuestion"
    has_many :leaderboards, class_name: "Trivia::QuestionLeaderboard", foreign_key: :trivia_question_id, dependent: :destroy
    has_many :trivia_answers, class_name: "Trivia::Answer", foreign_key: :trivia_question_id, dependent: :destroy
    has_many :available_answers, through: :available_question, source: :available_answers


    validates :time_limit, numericality: { greater_than: 0 },
              presence: true

    validates :cooldown_period, numericality: { greater_than: 5 },
              presence: true

    validates :type, inclusion: { in: %w(Trivia::SingleChoiceQuestion
                Trivia::MultipleChoiceQuestion Trivia::PictureQuestion
                Trivia::BooleanChoiceAQuestion Trivia::HangmanQuestion
              ),  message: "%{value} is not a valid type" }

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

    rails_admin do
      parent "Trivia::Game"

      edit do
        fields :round, :type, :time_limit, :question_order, :cooldown_period, :available_question
        #  trivia_round_id :bigint(8)
        #  type            :string
        #  start_date      :integer
        #  end_date        :integer
        #
        #
        field :type, :enum do
          enum do
            Trivia::Question.descendants.map(&:name)
          end
        end

        field :available_answers do
          read_only { true }
        end
      end
      nested do
        exclude_fields :round
        field :available_answers do
          read_only { true }
        end
      end
    end
  end
end

