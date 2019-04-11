# == Schema Information
#
# Table name: trivia_game_leaderboards
#
#  id             :bigint(8)        not null, primary key
#  trivia_game_id :bigint(8)
#  nb_points      :integer
#  position       :integer
#  average_time   :integer          default(0)
#  integer        :integer          default(0)
#  person_id      :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trivia::GameLeaderboard < ApplicationRecord
  belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id
  belongs_to :person, class_name: "Person"
end
