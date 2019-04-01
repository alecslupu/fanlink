class Trivia::Package < ApplicationRecord
  belongs_to :trivia_game, class_name: "Trivia::Game", counter_cache: :package_count
end
