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
    end
  end
end
