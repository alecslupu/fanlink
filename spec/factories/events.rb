FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    start_time { Time.now + 1.month }
  end
end
