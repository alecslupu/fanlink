class Trivia::Package < ApplicationRecord
  belongs_to :trivia_game, class_name: "Trivia::Game", counter_cache: :package_count

  has_many :trivia_questions, class_name: "Trivia::Question"

  enum status: %i[draft published locked closed]
end
