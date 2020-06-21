# frozen_string_literal: true

if !activity.deleted
  json.cache! ['v3', activity.updated_at, activity] do
    json.id activity.id
    json.quest_id activity.step.quest_id
    json.step_id activity.step_id
    json.description activity.description
    json.hint activity.hint
    json.picture_url activity.picture_optimal_url
    json.picture_width activity.picture_width
    json.picture_height activity.picture_height
    if activity.activity_types.count > 0
      json.requirements do
        json.array!(activity.activity_types) do |atype|
          next if atype.deleted
          json.partial! 'api/v3/activity_types/type', locals: { atype: atype }
        end
      end
    else
      json.requirements nil
    end
    json.deleted activity.deleted
    json.step activity.step
    json.created_at activity.created_at
  end
  if QuestCompletion.where(person_id: current_user.id, activity_id: activity.id).exists?
    json.completed true
  else
    json.completed false
  end
end
