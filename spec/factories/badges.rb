FactoryBot.define do
  factory :badge do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    action_type_id { FactoryBot.create(:action_type).id }
    point_value 10
  end
end
