# frozen_string_literal: true

json.action do
  json.cache! ['v3', @action_type], expires_in: 10.minutes do
    json.partial! 'action_type', locals: { action: @action_type, lang: nil }
  end
end
