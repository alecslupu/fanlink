class Trivia::Question < ApplicationRecord
  belongs_to :round, class_name: "Trivia::Round", counter_cache: :question_count
  has_many :trivia_available_answers, class_name: "Trivia::AvailableAnswer", foreign_key: :trivia_question_id
  has_many :trivia_answers, class_name: "Trivia::Answer"
  enum status: %i[draft published locked closed]
end
