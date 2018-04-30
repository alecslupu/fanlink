json.id quest.id.to_s
json.product_id quest.product_id.to_s
json.event_id quest.event_id.to_s
json.name quest.name
json.internal_name quest.internal_name
json.description quest.description
json.picture_url quest.picture_url
json.status quest.status.to_s
json.starts_at quest.starts_at.to_s
json.ends_at quest.ends_at.to_s
json.create_time quest.created_at.to_s
if quest.activities.count > 0
    json.activities quest.activities, partial: "api/v1/quests/activity", as: :activity
else
    json.activities nil
end
