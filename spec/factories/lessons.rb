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
