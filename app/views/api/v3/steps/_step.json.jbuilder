# frozen_string_literal: true

json.cache! ['v3', step.updated_at, step] do
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
    json.display "Step #{step.id}"
  end
end

if step.quest_activities.count > 0
  json.activities step.quest_activities.where(deleted: false),
                  partial: 'api/v3/quest_activities/activity',
                  as: :activity
else
  json.activities nil
end

unlocks_at = step.unlocks_at || nil
# Updates based on current user.
# json.step_completed step.step_completed
if step.step_completed.present?
  json.status step.step_completed.status
  unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute if unlocks_at.blank?
else
  json.status step.initial_status
end
unlocks_at ||= Time.zone.now.to_s
if @req_source == 'web'
  json.delay_unlock step.delay_unlock || 0
end
json.unlocks_at unlocks_at.to_datetime().utc.iso8601
