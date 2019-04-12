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

FactoryBot.define do
  factory :trivia_game_leaderboard, class: "Trivia::GameLeaderboard" do
    trivia_game { nil }
    nb_points { 1 }
    position { 1 }
    person { nil }
  end
end
