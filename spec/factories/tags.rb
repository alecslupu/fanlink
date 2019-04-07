FactoryBot.define do
  factory :tag do
    product {  current_product }
    sequence(:name) { |n| "Tag #{n}" }
  end
end
