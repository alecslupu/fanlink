if @progress.present? && @series_total < @progress.reward.completion_requirement
    if @progress.nil?
        json.pending_badge nil
    else
        json.pending_badge do
            json.badge_action_count @series_total
            json.badge do
                json.cache! ['v3', @progress.reward.badge] do
                    json.partial! "api/v3/badges/badge", locals: {badge: award.reward.badge}
                end
            end
        end
    end
else
    json.badges_awarded do
        json.array! @badges_awarded do |award|
            json.cache! ['v3', award.reward.badge] do
                json.partial! "api/v3/badges/badge", locals: {badge: award.reward.badge}
            end
        end
    end
end
