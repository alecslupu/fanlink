FactoryBot.define do
  factory :event do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Event #{n}" }
    starts_at { Time.now + 1.month }
  end
end
