FactoryBot.define do
  factory :person do
    product FactoryGirl.create(:product)
    sequence(:email) { |n| "person#{n}@example.com" }

  end
end
