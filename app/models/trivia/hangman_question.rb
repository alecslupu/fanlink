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
#

module Trivia
  class HangmanQuestion < Question
    belongs_to :available_question, class_name: "Trivia::HangmanAvailableQuestion", foreign_key: :available_question_id

    rails_admin do

    end
  end
end
