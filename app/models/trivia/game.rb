class Trivia::Game < ApplicationRecord
  has_many :trivia_packages, class_name: "Trivia::Package"
end
