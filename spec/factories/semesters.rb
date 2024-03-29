# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id          :bigint(8)        not null, primary key
#  product_id  :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#

require 'faker'
I18n.reload!

FactoryBot.define do
  factory :semester do
    product { current_product }
    sequence(:name) { |n| "Semester #{n}" }
    description { Faker::Lorem.paragraph }
    start_date { DateTime.current }
  end
end
