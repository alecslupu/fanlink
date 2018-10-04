require "faker"

FactoryBot.define do
  factory :coupon do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:code) { |n| "Coupon-#{n}" }
    description { Faker::Lorem.paragraph }
  end
end
