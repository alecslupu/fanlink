json.event do
    json.cache! ['v3', @event], expires_in: 10.minutes do
        json.partial! "event", locals: {event: @event, lang: @lang}
    end
end
