require "faker"
I18n.reload!

FactoryBot.define do
  factory :semester do
    product { current_product}
    sequence(:name) { |n| "Semester #{n}" }
    description { Faker::Lorem.paragraph }
    start_date { DateTime.current }
  end
end
