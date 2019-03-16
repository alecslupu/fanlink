FactoryBot.define do
  factory :answer do
    quizpage { nil }
    is_correct { "MyString" }
    boolean { "MyString" }
  end
end
