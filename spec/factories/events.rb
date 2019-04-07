FactoryBot.define do
  factory :event do
    product { current_product }
    sequence(:name) { |n| "Event #{n}" }
    starts_at { Time.now + 1.month }
    factory :event_with_product do
      # product { create(:product) }
    end
  end
end
