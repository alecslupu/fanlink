json.id activity.id.to_s
json.quest_id activity.quest_id.to_s
json.description activity.description
json.hint activity.hint
json.picture_url activity.picture_url
json.picture_width activity.picture.width
json.picture_height activity.picture.height
json.post activity.post
json.image activity.image
json.audio activity.audio
if defined?(activity.quest_completions) && !activity.quest_completions.empty?
    json.completed true
else 
    json.completed false
end
json.beacon do 
    json.partial! "api/v1/product_beacons/beacon", locals: { beacon: ProductBeacon.find(activity.beacon) }
end
json.activity_code activity.activity_code
json.deleted activity.deleted
json.step activity.step.to_s
json.created_at activity.created_at