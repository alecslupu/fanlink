json.step do
    json.cache! ['v3', @step, @lang], expires_in: 10.minutes do
        json.partial! "step", locals: { step: @step, lang: nil }
    end
end
