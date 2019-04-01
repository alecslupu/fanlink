class Trivia::GameLeaderboard < ApplicationRecord
  belongs_to :trivia_game, class_name: "Trivia::Game"
  belongs_to :person, class_name: "Person"
end
