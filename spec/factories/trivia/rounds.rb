# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  status           :integer          default("draft"), not null
#  complexity       :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  start_date       :integer
#  end_date         :integer
#  product_id       :integer          not null
#

FactoryBot.define do
  factory :trivia_round, class: "Trivia::Round" do
    product { current_product }

    game { create(:trivia_game) }
    leaderboard_size { game.leaderboard_size }
    status { :locked }
    start_date { 30.minutes.ago }
    end_date { 10.minutes.from_now }

    transient do
      with_leaderboard { false }
    end

    factory :started_trivia_round do
      start_date { 30.minutes.ago }
      end_date { 10.minutes.from_now }
    end

    factory :past_trivia_round do
      start_date { 30.minutes.ago }
      end_date { 10.minutes.ago }
      status { :closed }

      after :create do |round, options|
        if options.with_leaderboard
          create_list :trivia_round_leaderboard, round.leaderboard_size, round: round
        end
      end
    end

    factory :future_trivia_round do
      start_date { Time.zone.now.to_i + 10.minutes }
      # end_date { 20.minutes.from_now }
      status { :published }
    end

    after :create do |round, options|
      create_list :trivia_single_choice_question, 10, round: round, with_leaderboard: options.with_leaderboard
    end
  end
end
