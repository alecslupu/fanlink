# frozen_string_literal: true

json.cache! ["v3", "list", activity] do
  json.id activity.id.to_s
  json.quest_id activity.quest_id.to_s
  json.description activity.description
  json.deleted activity.deleted
  json.hint activity.hint
  json.picture_url activity.picture_optimal_url
  json.picture_width activity.picture.width
  json.picture_height activity.picture.height
  json.post activity.post
  json.status activity.status
  json.created_at activity.created_at
end
if activity.activity_types.count > 0
  json.requirements do
    json.array!(activity.activity_types) do |atype|
      # next if atype.deleted
      json.partial! "api/v3/activity_types/type", locals: { atype: atype }
    end
  end
else
  json.requirements nil
end
json.step do
  json.partial! "api/v3/steps/step", locals: { step: activity.step }
end
