FactoryBot.define do
  factory :level do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    points 1
  end
end
