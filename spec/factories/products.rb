FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:internal_name) { |n| "product#{n}" }
    enabled true
  end
end
