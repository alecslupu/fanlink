json.quest do
    json.cache! ['v3', @quest], expires_in: 10.minutes do
        json.partial! "quest", locals: { quest: @quest, lang: nil }
    end
end
