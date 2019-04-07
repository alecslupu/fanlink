FactoryBot.define do
  factory :answer do
    quiz_page { create(:quiz_page) }
    product { current_product }
    is_correct { "MyString" }
    description { "MyString" }
  end
end
