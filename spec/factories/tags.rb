FactoryBot.define do
  factory :tag do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Tag #{n}" }
  end
end