FactoryBot.define do
  factory :person_reward do
    reward { create(:reward) }
    person { create(:person) }
    source { "Test" }
  end
end