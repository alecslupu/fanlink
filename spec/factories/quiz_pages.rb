# frozen_string_literal: true

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
#  is_survey            :boolean          default(FALSE)
#

FactoryBot.define do
  factory :quiz_page do
    transient do
      that_is_mandatory { true }
    end

    product { current_product }
    quiz_text { 'MyString' }
    wrong_answer_page_id {}

    before :create do |qp, evalutator|
      if evalutator.that_is_mandatory
        cp1 = create(:certcourse_page, certcourse_page_order: 1, image_page: create(:image_page))
        cp2 = create(:certcourse_page, certcourse_page_order: 2)
        qp.certcourse_page = cp2
        qp.wrong_answer_page_id = cp1.id
        qp.is_optional = false
      else
        qp.certcourse_page = create(:certcourse_page)
        qp.is_optional = true
      end
    end

    before :create do |page|
      page.answers << build(:correct_answer, quiz_page: page)
      page.answers << build_list(:answer, 3, quiz_page: page)
    end

    after :create do |page|
      page.answers.map(&:save)
    end
  end
end
