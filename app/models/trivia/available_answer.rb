class Trivia::AvailableAnswer < ApplicationRecord
  belongs_to :trivia_question, class_name: "Trivia::Question"
  enum status: %i[draft published locked closed]

end
