# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id           :bigint(8)        not null, primary key
#  quiz_page_id :integer
#  description  :string           default(""), not null
#  is_correct   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :integer          not null
#

FactoryBot.define do
  factory :answer do
    quiz_page { create(:quiz_page) }
    product { current_product }
    is_correct { false }
    description { 'MyString' }

    factory :wrong_answers do
      is_correct { false }
    end
    factory :correct_answer do
      is_correct { true }
    end
  end
end
