json.progress do
    json.cache! ['v3', @progress], expires_in: 10.minutes do
        json.partial! "reward_progress", locals: { progress: @progress }
    end
end
