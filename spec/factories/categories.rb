FactoryBot.define do
  factory :category do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Category #{n}" }
    color { "#FFFFFF" }
    role { 0 }
  end
end
