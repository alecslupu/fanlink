json.cache! ["v3", step] do
  json.id step.id
  json.quest_id step.quest_id
  json.uuid step.uuid
  if !step.unlocks.blank?
    json.unlocks step.unlocks
  else
    json.unlocks nil
  end
  if step.display?
    json.display step.display
  else
    json.display "Step #{step.id.to_s}"
  end

  if step.quest_activities.count > 0
    json.activities step.quest_activities,  partial: "api/v3/quest_activities/activity", as: :activity
  else
    json.activities nil
  end
end
unlocks_at = step.unlocks_at || nil
# Updates based on current user.
if step.step_completed.present?
    json.status step.step_completed.status
    unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute unless unlocks_at.present?
else
    json.status step.initial_status
end
unlocks_at ||= Time.now.to_s
if current_user.app == "portal"
    json.delay_unlock step.delay_unlock || 0
end
json.unlocks_at unlocks_at.to_datetime().utc.iso8601
