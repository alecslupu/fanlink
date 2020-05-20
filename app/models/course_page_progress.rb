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

class CoursePageProgress < ApplicationRecord
  has_paper_trail
  belongs_to :certcourse_page, touch: true
  belongs_to :person
end
