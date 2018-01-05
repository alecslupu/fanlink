require "faker"

FactoryBot.define do
  factory :person do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    name { Faker::Name.name }
    password { "badpassword" }
  end
end
