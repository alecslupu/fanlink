require "faker"

FactoryBot.define do
  factory :contest do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Contest #{n}" }
    sequence(:internal_name) { |n| "contest_#{n}" }
    description { Faker::Lorem.paragraph }
  end
end