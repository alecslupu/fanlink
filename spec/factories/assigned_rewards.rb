FactoryBot.define do
  factory :assigned_reward do
    association :reward, factory: :badge_reward
    factory :assigned_as_quest do
      association :assigned, factory: :quest
    end
    factory :assigned_as_step do
      association :assigned, factory: :step
    end
    factory :assigned_as_quest_activity do
      association :assigned, factory: :quest_activity
    end
    factory :assigned_as_action_type do
      association :assigned, factory: :action_type
    end
  end
end
