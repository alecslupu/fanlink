# frozen_string_literal: true
if @progress.present?
  if @series_total < @progress.reward.completion_requirement
    json.pending_badge do
      json.badge_action_count @series_total
      json.badge do
        json.cache! ["v3", @progress.reward.badge] do
          json.partial! "api/v3/badges/badge", locals: { badge: @progress.reward.badge }
        end
      end
    end
  elsif @series_total >= @progress.reward.completion_requirement
    json.badges_awarded do
      json.array! Array.wrap(@progress.reward.badge) do |badge|
        json.cache! ["v3", badge] do
          json.partial! "api/v3/badges/badge", locals: { badge: badge }
        end
      end
    end
  end
else
  json.pending_badge nil
end
