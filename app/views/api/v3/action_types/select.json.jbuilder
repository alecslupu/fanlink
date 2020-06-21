# frozen_string_literal: true

json.action_types do
  json.array!(@action_types) do |action|
    if action.active?
      json.cache! ["v3", action, "select"], expires_in: 10.minutes do
        json.id action.id
        json.name action.name
        json.internal_name action.internal_name
      end
    end
  end
end
