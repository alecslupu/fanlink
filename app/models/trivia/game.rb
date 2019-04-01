class Trivia::Game < ApplicationRecord
  has_many :trivia_packages, class_name: "Trivia::Package"
  has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"
end
