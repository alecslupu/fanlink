# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_games
#
#  id                   :bigint(8)        not null, primary key
#  description          :text             default(""), not null
#  round_count          :integer
#  long_name            :string           not null
#  short_name           :string           not null
#  room_id              :bigint(8)
#  product_id           :bigint(8)
#  status               :integer          default("draft"), not null
#  leaderboard_size     :integer          default(100)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  start_date           :integer
#  end_date             :integer
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

FactoryBot.define do
  factory :trivia_game, class: 'Trivia::Game' do
    start_date { Faker::Time.backward(days: 5) }
    end_date { Faker::Time.forward(days: 5) }
    long_name { Faker::Lorem.words(number: 10) }
    short_name { Faker::Lorem.words(number: 3) }
    description { Faker::Lorem.paragraph  }
    product { current_product }
    room { create(:room) }
    leaderboard_size { 5 }
    status { 'draft' }

    transient do
      with_leaderboard { false }
    end

    factory :full_short_trivia_game do
      after :create do |game, options|
        create_list :trivia_prize, 3, game: game  # has_many
        create_list :past_trivia_round, 1, game: game, with_leaderboard: options.with_leaderboard   # has_many
        create_list :future_trivia_round, 1, game: game, with_leaderboard: options.with_leaderboard   # has_many
        create :trivia_round, game: game, with_leaderboard: options.with_leaderboard    # has_many
      end
    end
    factory :full_trivia_game do
      after :create do |game, options|
        create_list :trivia_prize, 3, game: game # has_many
        create_list :past_trivia_round, 3, game: game, with_leaderboard: options.with_leaderboard # has_many
        create_list :future_trivia_round, 3, game: game, with_leaderboard: options.with_leaderboard # has_many
        create :trivia_round, game: game, with_leaderboard: options.with_leaderboard # has_many
        # create_list :trivia_prize, 3, game: page   # has_many
      end
    end
  end
end
