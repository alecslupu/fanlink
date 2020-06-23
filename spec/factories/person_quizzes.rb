# frozen_string_literal: true

# == Schema Information
#
# Table name: person_quizzes
#
#  id               :bigint(8)        not null, primary key
#  person_id        :integer          not null
#  quiz_page_id     :integer          not null
#  answer_id        :integer
#  fill_in_response :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :person_quiz do
    person_id { create(:person).id }
    quiz_page_id { create(:quiz_page).id }
    answer_id { create(:answer).id }
    fill_in_response { Faker::Lorem.sentence }
  end
end
