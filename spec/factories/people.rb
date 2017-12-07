FactoryBot.define do
  factory :person do
    product { FactoryBot.create(:product) }
    sequence(:email) { |n| "person#{n}@example.com" }
  end
end
