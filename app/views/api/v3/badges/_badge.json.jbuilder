json.id badge.id.to_s
json.name badge.name(@lang)
json.internal_name badge.internal_name
json.description badge.description(@lang)
json.picture_url badge.picture_url
if badge.reward.assigned_rewards.by_type("ActionType").exists?
    json.action_type_id badge.reward.assigned_rewards.by_type("ActionType").first.id
else
    json.action_type_id nil
end
json.action_requirement badge.reward.completion_requirement
json.point_value badge.reward.points