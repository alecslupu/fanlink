# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint(8)        not null, primary key
#  semester_id :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#

require "faker"

FactoryBot.define do
  factory :course do
    semester { create(:semester) }
    sequence(:name) { |n| "Course #{n}" }
    description { Faker::Lorem.paragraph }
    start_date { DateTime.current }
  end
end
