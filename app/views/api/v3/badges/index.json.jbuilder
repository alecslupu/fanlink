# frozen_string_literal: true

for_user = (params.has_key?(:person_id) ? params[:person_id] : current_user.id)
badge_action_count = 0
json.badges do
  json.array! @badges.each do |b|
    if b.reward.present?
      if b.reward.series.present?
        reward_progress_where = RewardProgress.where(person_id: for_user, series: b.reward.series)
        badge_action_count = (reward_progress_where.exists? ? reward_progress_where.sum(:total) : 0)
      else
        progress_where = RewardProgress.where(person_id: for_user, reward_id: b.reward.id)
        badge_action_count = (progress_where.exists? ? progress_where.first.total : 0)
      end
    end
    json.badge_action_count badge_action_count
    json.badge do
      json.cache! ['v3', b] do
        json.partial! 'api/v3/badges/badge', locals: { badge: b, lang: nil }
      end
      if @badges_awarded.present? && b.reward.present?
        json.badge_awarded @badges_awarded.any? { |ba| ba.reward_id == b.reward.id }
      else
        json.badge_awarded false
      end
    end
  end
end
