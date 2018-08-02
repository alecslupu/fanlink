json.badge do
  json.cache! ["v3", @badge] do
    json.partial! "api/v3/badges/badge", locals: { badge: @badge, lang: nil }
  end
end
