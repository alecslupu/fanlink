# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_person_quiz_page_answers
#
#  id               :bigint           not null, primary key
#  person_id        :integer          not null
#  quiz_page_id     :integer          not null
#  answer_id        :integer
#  fill_in_response :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :person_quiz, class: 'Fanlink::Courseware::PersonQuizPageAnswer' do
    person_id { create(:person).id }
    quiz_page_id { create(:quiz_page).id }
    answer_id { create(:answer).id }
    product { current_product }
    fill_in_response { Faker::Lorem.sentence }
  end
end
