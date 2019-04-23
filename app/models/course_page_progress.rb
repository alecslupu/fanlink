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

class CoursePageProgress < ApplicationRecord
  belongs_to :certcourse_page
  belongs_to :person
end
