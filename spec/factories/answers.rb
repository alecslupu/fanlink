FactoryBot.define do
  factory :answer do
    quiz_page { create(:quiz_page) }
    product { current_product }
    is_correct { false }
    description { "MyString" }

    factory :wrong_answers do
      is_correct { false }
    end
    factory :correct_answer do
      is_correct { true }
    end
  end
end
