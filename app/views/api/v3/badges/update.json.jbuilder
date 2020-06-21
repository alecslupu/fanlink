# frozen_string_literal: true

json.badge do
  json.partial! 'api/v3/badges/badge', locals: { badge: @badge, lang: nil }
end
