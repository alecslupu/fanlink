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
    start_date { Faker::Time.backward(5) }
    end_date { Faker::Time.forward(5) }
    long_name { Faker::Lorem.words(10) }
    short_name { Faker::Lorem.words(3) }
    description { Faker::Lorem.paragraph  }
    uuid { Faker::Crypto.sha1 }
    product { current_product }
    room { create(:room) }
    leaderboard_size { 100 }


    factory :full_trivia_game do
      after :create do |game|
        create_list :trivia_prize, 3, game: game   # has_many
        create_list :past_trivia_round, 3, game: game   # has_many
        create_list :future_trivia_round, 3, game: game   # has_many
        create :trivia_round, game: game   # has_many
        # create_list :trivia_prize, 3, game: page   # has_many
      end
    end



  end
end
