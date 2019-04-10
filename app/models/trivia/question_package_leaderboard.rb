class Trivia::QuestionPackageLeaderboard < ApplicationRecord
  belongs_to :trivia_package, class_name: "Trivia::Round"
  belongs_to :person, class_name: "Person"
end
