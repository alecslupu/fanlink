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


require 'rails_helper'

RSpec.describe CoursePageProgress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
