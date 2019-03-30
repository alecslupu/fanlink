FactoryBot.define do
  factory :quiz_page do
    product { ActsAsTenant.current_tenant || Product.first || create(:product) }
    certcourse_page { create(:certcourse_page) }
    is_optional { false }
    quiz_text { "MyString" }
    wrong_answer_page_id { 1 }
  end
end
