if @progress.total < @progress.reward.completion_requirement
  if @progress.nil?
    json.pending_badge nil
  else
    json.pending_badge do
      json.badge_action_count @progress.total
      json.badge @progress.reward.badge, partial: "api/v3/badges/badge", as: :badge
    end
  end
else
    json.badges_awarded do
        json.array! @badges_awarded do |award|
            json.partial! "api/v3/badges/badge", locals: {badge: award.reward.badge}
        end
    end
end
