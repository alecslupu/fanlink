json.badge do
  json.partial! "api/v4/badges/badge", locals: { badge: @badge, lang: nil }
end
