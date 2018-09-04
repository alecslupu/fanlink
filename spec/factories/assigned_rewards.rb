FactoryBot.define do
  factory :assigned_quest_reward do
    reward_id { create(:reward).id }
    assigned_id { create(:quest).id }
    assigned_type { "Quest" }
  end
end