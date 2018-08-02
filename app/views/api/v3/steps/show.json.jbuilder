json.step do
    json.cache! ['v3', @step, @lang], expires_in: 10.minutes do
        json.partial! "step", locals: { step: @step, lang: nil }
    end
    unlocks_at = @step.unlocks_at || nil
    # Updates based on current user.
    if @step.step_completed.present?
        json.status step.step_completed.status
        unlocks_at = @step.step_completed.created_at.to_datetime.utc + @step.delay_unlock.minute unless unlocks_at.present?
    else
        json.status @step.initial_status
    end
    unlocks_at ||= Time.now.to_s
    if current_user.app == "portal"
        json.delay_unlock @step.delay_unlock || 0
    end
    json.unlocks_at unlocks_at.to_datetime().utc.iso8601
end
