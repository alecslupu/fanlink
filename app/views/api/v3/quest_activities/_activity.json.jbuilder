if !activity.deleted
  json.id activity.id.to_s
  json.quest_id activity.step.quest_id
  json.step_id activity.step_id
  json.description activity.description
  json.hint activity.hint
  json.picture_url activity.picture_optimal_url
  json.picture_width activity.picture.width
  json.picture_height activity.picture.height
  if defined?(activity.quest_completions) && !activity.quest_completions.empty?
    json.completed true
  else
    json.completed false
  end
  if activity.activity_types.count > 0
    json.requirements do
      json.array(activity.activity_types) do |atype|
          json.partial! "api/v3/activity_types/type", locals: { atype: atype }
        end
    end
  else
    json.requirements nil
  end
  json.deleted activity.deleted
  json.step activity.step
  json.created_at activity.created_at
end
