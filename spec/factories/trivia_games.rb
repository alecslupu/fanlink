# == Schema Information
#
# Table name: trivia_games
#
#  id               :bigint(8)        not null, primary key
#  start_date       :datetime
#  end_date         :datetime
#  description      :text             default(""), not null
#  round_count      :integer
#  long_name        :string           not null
#  short_name       :string           not null
#  room_id          :bigint(8)
#  product_id       :bigint(8)
#  uuid             :uuid
#  status           :integer          default("draft"), not null
#  leaderboard_size :integer          default(100)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :trivia_game, class: "Trivia::Game" do
    start_date { "2019-04-01 22:34:36" }
    end_date { "2019-04-01 22:34:36" }
    long_name { "MyString" }
    short_name { "MyString" }
    description { "" }
    product { create(:product) }
    room { create(:room) }
  end
end
