FactoryBot.define do
  factory :level_progress do
    person { create(:person) }
  end
end