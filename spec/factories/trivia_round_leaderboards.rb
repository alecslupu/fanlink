# == Schema Information
#
# Table name: trivia_round_leaderboards
#
#  id              :bigint(8)        not null, primary key
#  trivia_round_id :bigint(8)
#  points          :integer
#  position        :integer
#  person_id       :bigint(8)
#  average_time    :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer          not null
#

FactoryBot.define do
  factory :trivia_round_leaderboard, class: "Trivia::RoundLeaderboard" do
    product { current_product }

    round { create(:trivia_round) }
    points { Faker::Number.between(0, 10000) }
    position { Faker::Number.between(0, 10000) }
    average_time { Faker::Number.decimal(0, 6) }
    person { create(:person) }
  end
end
