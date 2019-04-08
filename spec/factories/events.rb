FactoryBot.define do
  factory :event do
    product { current_product }
    sequence(:name) { |n| "Event #{n}" }
    starts_at { rand(3.days).seconds.from_now }
    factory :event_with_product do
      # product { create(:product) }
    end

    factory :past_event do
      starts_at { 1.month.ago }
    end

    factory :future_event do
      starts_at { 1.month.from_now }
    end

  end
end
