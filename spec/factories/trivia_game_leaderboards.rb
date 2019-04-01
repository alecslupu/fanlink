FactoryBot.define do
  factory :trivia_game_leaderboard, class: 'Trivia::GameLeaderboard' do
    trivia_game { nil }
    nb_points { 1 }
    position { 1 }
    person { nil }
  end
end
