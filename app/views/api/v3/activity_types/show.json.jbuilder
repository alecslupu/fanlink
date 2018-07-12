json.type do
    json.cache! ['v3', @activity_type], expires_in: 10.minutes do
        json.partial! "type", locals: { atype: @activity_type, lang: nil }
    end
end
