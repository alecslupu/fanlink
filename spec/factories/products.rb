FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:subdomain) { |n| "product#{n}" }
    enabled true
  end
end
