class Trivia::Package < ApplicationRecord
  belongs_to :trivia_game, class_name: "Trivia::Game", counter_cache: :package_count

  has_many :trivia_questions, class_name: "Trivia::Question", foreign_key: :trivia_package_id
  has_many :leaderboards, class_name: "Trivia::PackageLeaderboard", foreign_key: :trivia_package_id

  enum status: %i[draft published locked closed]

  scope :published, -> { where(status: [:published, :locked, :closed]) }
end
