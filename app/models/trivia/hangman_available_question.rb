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
  class HangmanAvailableQuestion < AvailableQuestion
    has_many :active_questions, class_name: "Trivia::HangmanQuestion", inverse_of: :available_question, foreign_key: :available_question_id
  end
end
