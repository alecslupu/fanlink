# frozen_string_literal: true

json.badges do
  json.array! @badges.each do |b|
    json.badge_action_count @badge_action_counts[b.action_type_id] || 0
    json.badge_awarded @badges_awarded.include?(b)
    json.badge b, partial: "badge", as: :badge
  end
end
