# == Schema Information
#
# Table name: trivia_participants
#
#  id             :bigint(8)        not null, primary key
#  person_id      :bigint(8)
#  trivia_game_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trivia::Participant < ApplicationRecord
  belongs_to :person
  belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id
end
