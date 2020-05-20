# frozen_string_literal: true
json.actions do
  json.array!(@action_types) do |action|
    json.cache! ["v3", action], expires_in: 10.minutes do
      json.partial! "action_type", locals: { action: action, lang: nil }
      json.set! :rewards, action.rewards
    end
  end
end
