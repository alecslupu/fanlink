FactoryBot.define do
  factory :badge do
    product { current_product }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    action_type { create(:action_type) }
    point_value { 10 }
  end
end
