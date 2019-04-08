FactoryBot.define do
  factory :step do
    sequence(:display) { |n| "Step #{n}" }
    uuid {  UUIDTools::UUID.random_create.to_s }
    quest { create(:quest) }
  end
end
