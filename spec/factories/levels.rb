FactoryBot.define do
  factory :level do
    product { current_product }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    points { Faker::Number.between(10,100) }
  end
end
