FactoryBot.define do
  factory :room do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Room #{n}" }
    created_by_id { create(:person).id }
  end
end
