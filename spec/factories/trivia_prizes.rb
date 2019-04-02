FactoryBot.define do
  factory :trivia_prize, class: 'Trivia::Prize' do
    game { nil }
    status { 1 }
    description { "MyText" }
    position { 1 }
  end
end
