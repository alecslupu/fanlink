module Person::Trivia

  extend ActiveSupport::Concern
  included do
    has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"
    has_many :trivia_package_leaderboards, class_name: "Trivia::PackageLeaderboard"
  end
end
