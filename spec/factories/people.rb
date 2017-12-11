require "faker"

FactoryBot.define do
  factory :person do
    product { FactoryBot.create(:product) }
    sequence(:email) { |n| "person#{n}@example.com" }
    name { Faker::Name.name }
    password { "badpassword" }
    password_confirmation { "badpassword" }
  end
end
