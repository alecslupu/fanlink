json.actions do
    json.array!(@action_types) do |action|
      json.partial! "action_type", locals: { action: action, lang: @lang }
      json.set! :rewards, action.rewards
    end
end
