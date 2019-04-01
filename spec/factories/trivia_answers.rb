FactoryBot.define do
  factory :trivia_answer, class: 'Trivia::Answer' do
    person { nil }
    trivia_question { nil }
    answered { "MyString" }
    time { 1 }
  end
end
