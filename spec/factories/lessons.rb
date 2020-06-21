# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id          :bigint(8)        not null, primary key
#  course_id   :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  video       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#

require "faker"

FactoryBot.define do
  factory :lesson do
    course { create(:course) }
    sequence(:name) { |n| "Lesson #{n}" }
    description { Faker::Lorem.paragraph }
    video { Faker::Internet.url }
    start_date { DateTime.current }
  end
end
