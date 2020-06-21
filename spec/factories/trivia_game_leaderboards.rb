# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_game_leaderboards
#
#  id             :bigint(8)        not null, primary key
#  trivia_game_id :bigint(8)
#  points         :integer
#  position       :integer
#  average_time   :integer          default(0)
#  person_id      :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#

FactoryBot.define do
  factory :trivia_game_leaderboard, class: 'Trivia::GameLeaderboard' do
    product { current_product }

    game { create(:trivia_game) }
    points { 1 }
    position { 1 }
    person { create(:person) }
  end
end
