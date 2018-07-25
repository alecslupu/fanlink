json.badges do
  json.array! @badges.each do |b|
    reward_progress = b.reward.reward_progresses.where(person_id: current_user.id).first
    if b.reward.series
        json.badge_action_count RewardProgress.where(person_id: current_user.id, series: b.reward.series).sum(:total)
    else
        if reward_progress.present?
            json.badge_action_count  reward_progress.total
        else
            json.badge_action_count 0
        end
    end
    json.badge do
        json.cache! ['v3', b] do
            json.partial! "api/v3/badges/badge", locals: { badge: b, lang: nil }
        end
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
    end
  end
end
