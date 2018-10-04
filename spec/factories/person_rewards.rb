FactoryBot.define do
  factory :person_reward do
    reward { create(:badge_reward) }
    person { create(:person) }
    source { "Test" }
  end
end
