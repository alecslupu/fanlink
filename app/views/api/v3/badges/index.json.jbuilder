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
        json.partial! "api/v3/badges/badge", locals: { badge: b, lang: nil }
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
