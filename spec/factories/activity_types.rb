FactoryBot.define do
  factory :activity_type do
    activity_id { create(:quest_activity).id }
    value { { id: 1, description: "Product Beacon" } }
    atype { :beacon }
  end
end