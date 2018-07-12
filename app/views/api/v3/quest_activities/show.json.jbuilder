json.activity do
    json.cache! ['v3', @quest_activity], expires_in: 10.minutes do
        json.partial! "activity", locals: { activity: @quest_activity }
    end
end
