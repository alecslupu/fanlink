FactoryBot.define do
  factory :room do
    product { current_product}
    sequence(:name) { |n| "Room #{n}" }
    created_by_id { create(:person).id }
  end
end
