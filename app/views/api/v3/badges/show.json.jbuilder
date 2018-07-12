json.badge do
    json.cache! ['v3', @badge], expires_in: 10.minutes do
        json.partial! "api/v3/badges/badge", locals: { badge: @badge, lang: nil }
    end
end
