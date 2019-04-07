require "faker"

FactoryBot.define do
  factory :person do
    product { current_product }
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    name { Faker::Name.name }
    password { "badpassword" }
    birthdate { "2000-01-01" }

    factory :recommended_person do
      recommended { true }
    end

    factory :admin_user do
      role { :admin }
    end
  end
end
