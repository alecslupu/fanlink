if !step.deleted
    unlocks ||= []
    unlocks << step.unlocks
    json.id step.id.to_s
    json.quest_id step.quest_id.to_s
    json.uuid step.uuid
    if !step.unlocks.blank?
        json.unlocks unlocks
    else
        json.unlocks nil
    end
    if step.display?
        json.display step.display
    else
        json.display "Step #{step.id.to_s}"
    end
    if step.quest_completions.exists?
        if step.quest_completions.count == step.quest_activities.count
            json.status "completed"
        end
    elsif !step.step_completed.blank?
        json.status step.step_completed.status
    else
        json.status step.initial_status
    end
    if step.quest_activities.count > 0
        json.activities step.quest_activities,  partial: "api/v3/quest_activities/activity", as: :activity
    else
        json.activities nil
    end
    if step.delay_unlock > 0
        json.delay_unlock step.delay_unlock
        json.unlocks_at step.delay_unlock.minute.from_now.utc.iso8601
    else
        json.delay_unlock 0
        json.unlocks_at Time.now.utc.iso8601
    end
end
