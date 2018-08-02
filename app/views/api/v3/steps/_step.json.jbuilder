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
