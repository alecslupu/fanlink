class Trivia::AvailableAnswer < ApplicationRecord
  belongs_to :trivia_question, class_name: Trivia::Question
end
