# frozen_string_literal: true
# == Schema Information
#
# Table name: course_page_progresses
#
#  id                 :bigint(8)        not null, primary key
#  passed             :boolean          default(FALSE)
#  certcourse_page_id :bigint(8)
#  person_id          :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :course_page_progress do
    passed { false }
    certcourse_page { create(:certcourse_page) }
    person { create(:person) }
  end
end
