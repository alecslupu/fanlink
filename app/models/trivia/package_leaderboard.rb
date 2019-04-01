class Trivia::PackageLeaderboard < ApplicationRecord
  belongs_to :trivia_package, class_name: "Trivia::Package"
  belongs_to :person, class_name: "Person"
end
