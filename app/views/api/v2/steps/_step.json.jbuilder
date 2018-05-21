if !step.deleted
    json.id step.id.to_s
    json.quest_id step.quest_id.to_s
    if !step.unlocks.empty?
        json.unlocks step.unlocks
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
        elsif step.step_completed.exists?
            json.status step.step_completed.status
        else
            json.status step.initial_status
        end
    else
        json.status step.initial_status
    end
    if step.quest_activities.count > 0
        json.activities step.quest_activities,  partial: "api/v2/quest_activities/activity", as: :activity
    else
        json.activities nil
    end
end