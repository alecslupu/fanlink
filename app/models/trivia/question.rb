class Trivia::Question < ApplicationRecord
  belongs_to :question_package, class_name: "Trivia::QuestionPackage", counter_cache: :question_count
  has_many :trivia_available_answers, class_name: "Trivia::AvailableAnswer", foreign_key: :trivia_question_id
  has_many :trivia_answers, class_name: "Trivia::Answer"
  enum status: %i[draft published locked closed]
end
