quest_completed = current_user.quest_completed.find {|x| x.quest_id == quest.id}
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
json.completed ((quest_completed) ? true : false)
json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
if quest.steps.count > 0
    json.steps quest.steps, partial: "api/v3/steps/step", as: :step
else
    json.steps nil
end

quest.rewards.each do |assigned|
    if assigned.badge
        json.assigned_badge assigned.badge
        json.badge assigned.badge, partial: "api/v3/badges/badge", as: :badge
    else
       json.badge nil
    end
end

