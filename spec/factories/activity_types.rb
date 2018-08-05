FactoryBot.define do
  factory :activity_type do
    activity_id { create(:quest_activity).id }
    value { { id: 1, description: "Product Beacon" } }
    # sequence(:name) { |n| "Action #{n}" }
    # sequence(:internal_name) { |n| "action_#{n}" }
  end
end