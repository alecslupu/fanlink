FactoryBot.define do
  factory :action_type do
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
  end
end
