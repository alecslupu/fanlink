FactoryBot.define do
  factory :level do
    product { current_product }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    points { 1 }
  end
end
