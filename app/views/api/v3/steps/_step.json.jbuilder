json.id step.id.to_s
json.quest_id step.quest_id.to_s
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

unlocks_at = nil
# Updates based on current user.
if step.quest_completions.present?
    if step.quest_completions.count >= step.quest_activities.count
        json.status "completed"
    end
elsif step.step_completed.present?
    json.status step.step_completed.status
    unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute
else
    json.status step.initial_status
end
unlocks_at ||= Time.now.to_s
if current_user.app == "portal"
    json.delay_unlock step.delay_unlock || 0
end
    json.unlocks_at unlocks_at.to_datetime().utc.iso8601
end
