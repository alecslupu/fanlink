# frozen_string_literal: true

json.quest do
  json.partial! 'quest', locals: { quest: @quest, lang: nil }
  @quest.rewards.each do |assigned|
    if assigned.badge
      json.assigned_badge assigned.badge
      json.badge do
        json.partial! 'api/v3/badges/badge', locals: { badge: assigned.badge }
      end
    else
      json.badge nil
    end
  end
end
