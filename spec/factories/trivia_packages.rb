FactoryBot.define do
  factory :trivia_package, class: 'QuestionPackage' do
    start_date { "2019-04-01 22:36:15" }
    end_date { "2019-04-01 22:36:15" }
    question_count { 1 }
    game_id { nil }
  end
end
