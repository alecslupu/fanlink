# == Schema Information
#
# Table name: trivia_available_questions
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  cooldown_period :integer
#  time_limit      :integer
#  status          :integer
#  type            :string
#  topic_id        :integer
#  complexity      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Trivia
  class AvailableQuestion < ApplicationRecord
    belongs_to :topic, class_name: "Trivia::Topic"
    has_many :available_answers, class_name: "Trivia::AvailableAnswer", foreign_key: :trivia_question_id
    has_many :active_questions, class_name: "Trivia::Question", inverse_of: :available_question

    enum status: %i[draft published locked closed]
    accepts_nested_attributes_for :available_answers, allow_destroy: true

    rails_admin do
      edit do
        include_all_fields

        field :type, :enum do
          enum do
            Trivia::AvailableQuestion.descendants.map(&:name)
          end
        end
      end
    end
  end
end
