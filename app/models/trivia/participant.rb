class Trivia::Participant < ApplicationRecord
  belongs_to :person
  belongs_to :trivia_game
end
