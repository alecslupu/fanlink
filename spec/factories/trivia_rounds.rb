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
#  round_order      :integer          default(1), not null
#  status           :integer          default("draft"), not null
#  uuid             :uuid
#  complexity       :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :trivia_round, class: "Trivia::Round" do
    game { create(:trivia_game) }
    leaderboard_size { game.leaderboard_size }
    status { :locked }
    sequence(:round_order) { |n| n }

    factory :started_trivia_round do
      start_date { 30.minutes.ago   }
      end_date { 10.minutes.from_now}
    end

    factory :past_trivia_round do
      start_date { 30.minutes.ago }
      end_date { 10.minutes.ago }
      status { :closed }

      after :create do |round|
        create_list :trivia_round_leaderboard, round.leaderboard_size, round: round
      end
    end

    factory :future_trivia_round do
      start_date { 10.minutes.from_now }
      end_date { 20.minutes.from_now }
      status { :published }
    end

    after :create do |round|
      create_list :trivia_question, 10, round: round
    end
  end
end
