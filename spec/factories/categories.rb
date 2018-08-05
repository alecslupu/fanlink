FactoryBot.define do
  factory :category do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Category #{n}" }
  end
end