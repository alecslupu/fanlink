json.badge do
    json.partial! "api/v2/badges/badge", locals: { badge: @badge, lang: nil }
end
