FactoryBot.define do
  factory :reward_progress do
    person { create(:person) }
    reward { create(:badge_reward) }
  end
end
