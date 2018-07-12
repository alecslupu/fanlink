json.type do
    json.cache! do
        json.partial! "type", locals: { atype: @activity_type, lang: nil }
    end
end
