FactoryBot.define do
  factory :quiz_page do
    certcourse_page { nil }
    is_optional { false }
    quiz_text { "MyString" }
    color_text { "MyString" }
    wrong_answer_page_id { 1 }
  end
end
