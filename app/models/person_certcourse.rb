# frozen_string_literal: true

# == Schema Information
#
# Table name: person_certcourses
#
#  id                     :bigint           not null, primary key
#  person_id              :integer          not null
#  certcourse_id          :integer          not null
#  last_completed_page_id :integer
#  is_completed           :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class PersonCertcourse < Fanlink::Courseware::PersonCourse
end
