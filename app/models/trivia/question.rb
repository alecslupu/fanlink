class Trivia::Question < ApplicationRecord
  belongs_to :trivia_package, class_name: Trivia::Package, counter_cache: :question_count
  has_many :trivia_available_answers, class_name: Trivia::AvailableAnswer
end
