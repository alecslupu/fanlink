class Trivia::Game < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product, class_name: "Product"
  has_many :trivia_packages, class_name: "Trivia::Package"
  has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"
end
