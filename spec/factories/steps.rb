FactoryBot.define do
  factory :step do
    sequence(:display) { |n| "Step #{n}" }
    quest { create(:quest) }
  end
end