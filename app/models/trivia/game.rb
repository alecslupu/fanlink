module Trivia
  class Game < ApplicationRecord
    acts_as_tenant(:product)
    belongs_to :product, class_name: "Product"
    belongs_to :room, class_name: "Room"
    has_many :trivia_packages, class_name: "Trivia::Package", foreign_key: :trivia_game_id
    has_many :trivia_prizes, :class_name => "Trivia::Prize", foreign_key: :trivia_game_id
    has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"

    enum status: %i[draft published locked closed]
  end
end
