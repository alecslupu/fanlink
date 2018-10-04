FactoryBot.define do
  factory :quest_completed do
    person { create(:person) }
    quest { create(:quest) }
  end
end