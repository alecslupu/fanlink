FactoryBot.define do
  factory :trivia_question, class: 'Trivia::Question' do
    start_date { "2019-04-01 22:39:26" }
    end_date { "2019-04-01 22:39:26" }
    points { 1 }
    trivia_package { nil }
    time_limit { 1 }
  end
end
