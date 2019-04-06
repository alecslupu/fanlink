module Trivia
  class Game < ApplicationRecord
    acts_as_tenant(:product)
    belongs_to :product, class_name: "Product"
    belongs_to :room, class_name: "Room"
    has_many :packages, class_name: "Trivia::Package", foreign_key: :trivia_game_id
    has_many :prizes, class_name: "Trivia::Prize", foreign_key: :trivia_game_id
    has_many :leaderboards, class_name: "Trivia::GameLeaderboard", foreign_key: :trivia_game_id

    enum status: %i[draft published locked closed]

    scope :recent, -> { where(status: [:published, :locked, :closed]).where(start_date: 30.days.ago.beginning_of_day..DateTime::Infinity.new) }
  end
end
