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

    enum status: %i[draft published locked closed]
    accepts_nested_attributes_for :available_answers, allow_destroy: true
  end
end
