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
  class BooleanChoiceQuestion < Question
    belongs_to :available_question, class_name: "Trivia::BooleanChoiceAvailableQuestion", foreign_key: :available_question_id
  end
end
