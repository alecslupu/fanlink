FactoryBot.define do
  factory :category do
    product { current_product }
    sequence(:name) { |n| "Category #{n}" }
    color { "#FFFFFF" }
    role { 0 }
  end
end
