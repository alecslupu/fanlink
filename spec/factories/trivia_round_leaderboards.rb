FactoryBot.define do
  factory :trivia_round_leaderboard, class: "Trivia::RoundLeaderboard" do
    trivia_package { nil }
    nb_points { 1 }
    position { 1 }
    person { nil }
  end
end
