require "faker"

FactoryBot.define do
  factory :course do
    semester { create(:semester) }
    sequence(:name) { |n| "Course #{n}" }
    description { Faker::Lorem.paragraph }
    start_date { DateTime.current }
  end
end
