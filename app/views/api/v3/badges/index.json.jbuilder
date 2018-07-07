json.badges do
  json.array! @badges.each do |b|
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
