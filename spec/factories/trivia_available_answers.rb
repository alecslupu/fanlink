FactoryBot.define do
  factory :trivia_available_answer, class: 'Trivia::AvailableAnswer' do
    trivia_question { nil }
    name { "MyString" }
    hint { "MyString" }
    is_correct { false }
  end
end
