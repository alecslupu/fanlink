# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_person_courses
#
#  id                     :bigint           not null, primary key
#  person_id              :integer          not null
#  course_id              :integer          not null
#  last_completed_page_id :integer
#  is_completed           :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  product_id             :integer
#

FactoryBot.define do
  factory :person_course, class: 'Fanlink::Courseware::PersonCourse' do
    person { create(:person) }
    course { create(:certcourse) }
    product { current_product }
  end
end
