class Trivia::RoundLeaderboard < ApplicationRecord
  belongs_to :round, class_name: "Trivia::Round"
  belongs_to :person, class_name: "Person"
end
