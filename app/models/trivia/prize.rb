class Trivia::Prize < ApplicationRecord
  belongs_to :trivia_game, class_name: "Trivia::Game"

  has_attached_file :photo

  enum status: %i[draft published locked closed]

  scope :published, -> { where(status: [:published, :locked]) }
end
