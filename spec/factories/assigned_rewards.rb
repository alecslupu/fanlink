# frozen_string_literal: true

# == Schema Information
#
# Table name: assigned_rewards
#
#  id            :bigint(8)        not null, primary key
#  reward_id     :integer          not null
#  assigned_id   :integer          not null
#  assigned_type :text             not null
#  max_times     :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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
