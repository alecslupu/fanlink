require "faker"

FactoryBot.define do
  factory :coupon do
    product { current_product }
    sequence(:code) { |n| "Coupon-#{n}" }
    description { Faker::Lorem.paragraph }
  end
end
