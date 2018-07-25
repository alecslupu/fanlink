json.badge do
    json.cache! ['v3', @badge], expires_in: 10.minutes do
        json.partial! "api/v3/badges/badge", locals: { badge: @badge, lang: nil }
    end
    if @badge.reward.present?
        if @badge.reward.assigned_rewards.present? && @badge.reward.assigned_rewards.by_type("ActionType").exists?
            json.action_type_id @badge.reward.assigned_rewards.by_type("ActionType").first.id
        else
            json.action_type_id nil
        end
        json.action_requirement @badge.reward.completion_requirement
        json.point_value @badge.reward.points
    else
        json.action_type_id nil
        json.action_requirement nil
        json.point_value nil
    end
    if current_user.app == 'portal'
        json.issued_to @badge.issued_to
        json.issued_from @badge.issued_from
    end
end
