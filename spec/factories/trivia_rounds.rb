# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  start_date       :datetime
#  end_date         :datetime
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  package_order    :integer          default(1), not null
#  status           :integer          default("draft"), not null
#  uuid             :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  complexity       :integer          default(1)
#

FactoryBot.define do
  factory :trivia_round, class: "Trivia::Round" do
    start_date { "2019-04-01 22:36:15" }
    end_date { "2019-04-01 22:36:15" }
    question_count { 1 }
    game_id { nil }
  end
end
