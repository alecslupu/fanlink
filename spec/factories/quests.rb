require "faker"

FactoryBot.define do
  factory :quest do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Quest #{n}" }
    sequence(:internal_name) { |n| "quest_#{n}" }
    description { Faker::Lorem.paragraph }
    starts_at { Time.now }
    step { create(:step) }
  end
end