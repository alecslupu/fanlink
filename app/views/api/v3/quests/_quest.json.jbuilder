# frozen_string_literal: true

json.cache! ["v3", quest.updated_at, @lang, quest] do
  json.id quest.id.to_s
  json.product_id quest.product_id.to_s
  json.event_id quest.event_id.to_s
  json.name quest.name
  json.internal_name quest.internal_name
  json.description quest.description
  json.picture_url quest.picture_optimal_url
  json.picture_width quest.picture_width
  json.picture_height quest.picture_height
  json.status quest.status.to_s
  json.starts_at quest.starts_at
  json.ends_at quest.ends_at
  json.create_time quest.created_at.to_s
end

quest_completed = current_user.quest_completed.find { |x| x.quest_id == quest.id }
json.completed ((quest_completed) ? true : false)
json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
if quest.steps.count > 0
  json.steps do
    json.array!(quest.steps) do |step|
      json.partial! "api/v3/steps/step", locals: { step: step }
    end
  end
else
  json.steps nil
end

quest.rewards.each do |assigned|
  if assigned.badge
    json.assigned_badge assigned.badge
    json.badge do
      json.partial! "api/v3/badges/badge", locals: { badge: assigned.badge }
    end
  else
    json.badge nil
  end
end
