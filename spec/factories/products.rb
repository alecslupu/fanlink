FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:internal_name) { |n| "product#{n}" }
    age_requirement { 18 }
    enabled true
  end
end
