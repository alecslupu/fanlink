json.event do
    json.cache! ['v3', @event, @lang] do
        json.partial! 'event', locals: { event: @event, lang: @lang }
    end
    if @event.ends_at.present?
        json.ends_at @event.ends_at.to_s
    else
        json.ends_at nil
    end
end
