# frozen_string_literal: true

for_user = (params.has_key?(:person_id) ? params[:person_id] : current_user.id)
badge_action_count = 0
json.badges do
  json.array! @badges.each do |b|
    if b.reward.present?
      if b.reward.series.present?
        badge_action_count = ((RewardProgress.where(person_id: for_user, series: b.reward.series).exists?) ? RewardProgress.where(person_id: for_user, series: b.reward.series).sum(:total) : 0)
      else
        badge_action_count = ((RewardProgress.where(person_id: for_user, reward_id: b.reward.id).exists?) ? RewardProgress.where(person_id: for_user, reward_id: b.reward.id).first.total : 0)
      end
    end
    json.badge_action_count badge_action_count
    json.badge do
      json.cache! ["v3", b] do
        json.partial! "api/v3/badges/badge", locals: { badge: b, lang: nil }
      end
      if @badges_awarded.present? && b.reward.present?
        json.badge_awarded @badges_awarded.any? { |ba| ba.reward_id == b.reward.id }
      else
        json.badge_awarded false
      end
    end
  end
end
