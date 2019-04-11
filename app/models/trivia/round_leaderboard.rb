class Trivia::RoundLeaderboard < ApplicationRecord
  belongs_to :round, class_name: "Trivia::Round", foreign_key: :trivia_round_id
  belongs_to :person, class_name: "Person"
end
