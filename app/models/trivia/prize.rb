class Trivia::Prize < ApplicationRecord
  belongs_to :game, class_name: "Trivia::Game", foreign_key: :game_id

  has_attached_file :photo
end
