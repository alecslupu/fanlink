# frozen_string_literal: true

if @badge_awards.is_a?(Hash)
  if @badge_awards.empty?
    json.pending_badge nil
  else
    json.pending_badge do
      json.badge_action_count @badge_awards.values.first
      json.badge @badge_awards.keys.first, partial: "api/v1/badges/badge", as: :badge
    end
  end
else
  json.badges_awarded @badge_awards, partial: "api/v1/badges/badge", as: :badge
end
