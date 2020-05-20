# frozen_string_literal: true
json.id badge.id
json.name badge.name(@lang)
json.internal_name badge.internal_name
json.description badge.description(@lang)
json.picture_url badge.picture_url
if badge.reward.present?
  if badge.reward.assigned_rewards.present? && badge.reward.assigned_rewards.by_type("ActionType").exists?
    json.action_type_id badge.reward.assigned_rewards.by_type("ActionType").first.id
  else
    json.action_type_id nil
  end
  json.action_requirement badge.reward.completion_requirement
  json.point_value badge.reward.points
else
  json.action_type_id nil
  json.action_requirement nil
  json.point_value nil
end
if @req_source == "web"
  json.issued_to badge.issued_to
  json.issued_from badge.issued_from
end
json.reward badge.reward
json.assigned_rewards badge.assigned_rewards
