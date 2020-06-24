# frozen_string_literal: true

action_types = false
quests = false
steps = false
quest_activities = false
badges = false

json.id reward.id
json.product_id reward.product_id
json.name reward.name
json.(reward, :internal_name, :reward_type, :reward_type_id, :series, :completion_requirement,
      :points, :status, :deleted)
json.created_at reward.created_at.to_s
json.updated_at reward.updated_at.to_s
reward.assigned_rewards.each do |assigned|
  if assigned.assigned_type == 'ActionType'
    action_types = true
    json.action_types do
      json.child! do
        json.partial! 'api/v3/action_types/action_type', locals: { action: assigned.assigned, lang: nil }
        json.set! :max_times, assigned.max_times
      end
    end
  elsif assigned.assigned_type == 'Quest'
    quests = true
    json.quests do
      json.child! do
        json.partial! 'api/v3/quests/quest', locals: { quest: assigned.assigned, lang: nil }
        json.set! :max_times, assigned.max_times
      end
    end
  elsif assigned.assigned_type == 'Step'
    steps = true
    json.steps do
      json.child! do
        json.partial! 'api/v3/steps/step', locals: { step: assigned.assigned, lang: nil }
        json.set! :max_times, assigned.max_times
      end
    end
  elsif assigned.assigned_type == 'QuestActivity'
    quest_activities = true
    json.quest_activities do
      json.child! do
        json.partial! 'api/v3/quest_activities/activity', locals: { activity: assigned.assigned, lang: nil }
        json.set! :max_times, assigned.max_times
      end
    end
  elsif assigned.assigned_type == 'Badge'
    badges = true
    json.badges do
      json.child! do
        json.partial! 'api/v3/badges/badge', locals: { badge: assigned.assigned, lang: nil }
        json.set! :max_times, assigned.max_times
      end
    end
  else
    nil
  end
end
if !action_types
  json.action_types nil
end

if !quests
  json.quests nil
end
if !steps
  json.steps nil
end
if !quest_activities
  json.quest_activities nil
end
if !badges
  json.badges nil
end
