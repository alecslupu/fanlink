FactoryBot.define do
  factory :step do
    quest { create(:quest) }
  end
end