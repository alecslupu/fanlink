# == Schema Information
#
# Table name: quiz_pages
#
#  id                   :bigint(8)        not null, primary key
#  certcourse_page_id   :integer
#  is_optional          :boolean          default(FALSE)
#  quiz_text            :string           default(""), not null
#  wrong_answer_page_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :integer          not null
#

FactoryBot.define do
  factory :quiz_page do
    product { current_product}
    certcourse_page { create(:certcourse_page) }
    is_optional { false }
    quiz_text { "MyString" }
    wrong_answer_page_id { 1 }
  end
end
