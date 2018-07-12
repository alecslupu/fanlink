json.level_progress do
    json.cache ['v3', @level_progress], expires_in: 10.minutes do
        json.partial! "level_progress", locals: { progress: @level_progress, lang: nil }
    end
end
