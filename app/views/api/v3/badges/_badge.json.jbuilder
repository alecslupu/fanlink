json.id badge.id.to_s
json.name badge.name(@lang)
json.internal_name badge.internal_name
json.description badge.description(@lang)
json.picture_url badge.picture_url
if b.reward.present?
    if b.reward.assigned_rewards.present? && b.reward.assigned_rewards.by_type("ActionType").exists?
        json.action_type_id b.reward.assigned_rewards.by_type("ActionType").first.id
    else
        json.action_type_id nil
    end
    json.action_requirement b.reward.completion_requirement
    json.point_value b.reward.points
else
    json.action_type_id nil
    json.action_requirement nil
    json.point_value nil
end
if current_user&.app == 'portal'
    json.issued_to b.issued_to
    json.issued_from b.issued_from
end
json.reward b.reward
if !@badges_awarded.nil?
    @badges_awarded.each do |awarded|
        if awarded.reward.reward_type_id == b.id
            json.badge_awarded  true
        else
            json.badge_awarded false
        end
    end
else
    json.badge_awarded false
end
json.assigned_rewards b.assigned_rewards
