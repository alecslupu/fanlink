# frozen_string_literal: true

# == Schema Information
#
# Table name: course_page_progresses
#
#  id                 :bigint           not null, primary key
#  passed             :boolean          default(FALSE)
#  certcourse_page_id :bigint
#  person_id          :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :course_page_progress, class: 'Fanlink::Courseware::PersonCoursePageProgress' do
    passed { false }
    course_page { create(:certcourse_page) }
    person { create(:person) }
    product { current_product }
  end
end
