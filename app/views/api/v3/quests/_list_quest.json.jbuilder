# frozen_string_literal: true
json.id quest.id.to_s
json.product_id quest.product_id.to_s
json.event_id quest.event_id.to_s
json.name quest.name(@lang)
json.internal_name quest.internal_name
json.description quest.description(@lang)
json.picture_url quest.picture_optimal_url
json.picture_width quest.picture.width
json.picture_height quest.picture.height
json.status quest.status.to_s
json.starts_at quest.starts_at.to_s
json.ends_at quest.ends_at.to_s
json.create_time quest.created_at.to_s
if quest.rewards.count > 0
  json.rewards quest.rewards
else
  json.rewads nil
end
