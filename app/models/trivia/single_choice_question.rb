# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_questions
#
#  id                    :bigint           not null, primary key
#  trivia_round_id       :bigint
#  time_limit            :integer          default(30)
#  type                  :string
#  question_order        :integer          default(1), not null
#  cooldown_period       :integer          default(6)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  start_date            :integer
#  end_date              :integer
#  available_question_id :integer
#  product_id            :integer          not null
#

module Trivia
  class SingleChoiceQuestion < Question
    belongs_to :available_question,
               class_name: 'Trivia::SingleChoiceAvailableQuestion',
               foreign_key: :available_question_id
  end
end
