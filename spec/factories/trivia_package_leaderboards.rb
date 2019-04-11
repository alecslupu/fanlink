FactoryBot.define do
  factory :trivia_package_leaderboard, class: 'QuestionPackageLeaderboard' do
    trivia_package { nil }
    nb_points { 1 }
    position { 1 }
    person { nil }
  end
end
