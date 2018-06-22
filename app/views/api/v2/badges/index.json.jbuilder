json.badges do
  json.array! @badges.each do |b|
    json.badge do
        json.partial! "api/v2/badges/badge", locals: { badge: b, lang: nil }
        json.reward b.reward
        if @badges_awarded
            json.badges_awarded  @badges_awarded
        else
            json.badges_awarded nil
        end
        json.assigned_rewards b.assigned_rewards
    end
  end
end
