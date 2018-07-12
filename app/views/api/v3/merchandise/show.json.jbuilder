json.merchandise do
    json.cache! ['v3', @merchandise], expires_in: 10.minutes do
        json.partial! "merchandise", locals: { merchandise: @merchandise, lang: @lang}
    end
end
