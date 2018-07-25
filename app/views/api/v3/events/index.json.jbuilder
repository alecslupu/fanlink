if current_user.present? && current_user.role == 'super_admin'
    json.events do
        json.array!(@events) do |event|
            json.cache! ['v3', 'super_admin', event] do
                json.partial! "event", locals: { event: event, lang: @lang}
            end
            if !event.ends_at.to_s.empty?
                json.ends_at event.ends_at.to_s
            else
                json.ends_at nil
            end
        end
    end
else
    json.events do
        json.array!(@events) do |event|
            next if event.deleted
            json.cache! ['v3', event, @lang] do
                json.partial! "event", locals: { event: event, lang: @lang }
            end
            if event.ends_at.present?
                json.ends_at event.ends_at.to_s
            else
                json.ends_at nil
            end
        end
    end
end
