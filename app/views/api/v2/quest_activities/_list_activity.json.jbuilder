# frozen_string_literal: true
json.id activity.id.to_s
json.quest_id activity.quest_id.to_s
json.description activity.description
json.deleted activity.deleted
json.hint activity.hint
json.picture_url activity.picture_optimal_url
json.picture_width activity.picture.width
json.picture_height activity.picture.height
json.post activity.post
if activity.activity_types.count > 0
  json.requirements activity.activity_types, partial: "api/v2/activity_types/type", as: :atype
else
  json.requirements nil
end
json.status activity.status
json.step do
  json.partial! "api/v2/steps/step", locals: { step: activity.step }
end
json.created_at activity.created_at
