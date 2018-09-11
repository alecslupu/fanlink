require "faker"

FactoryBot.define do
  factory :quest do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    name { "Quest 1" }
    internal_name { "quest_1" }
    description { Faker::Lorem.paragraph }
    starts_at { Time.now }
  end
end
