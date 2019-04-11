FactoryBot.define do
  factory :trivia_question_leaderboard, class: 'Trivia::QuestionLeaderboard' do
    trivia_question { nil }
    nb_points { 1 }
    person { nil }
  end
end
