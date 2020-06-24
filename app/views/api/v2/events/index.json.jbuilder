# frozen_string_literal: true

if current_user.role == 'super_admin'
  json.events @events, partial: 'event', as: :event
else
  json.events do
    json.array!(@events) do |event|
      next if event.deleted

      json.partial! 'event', locals: { event: event, lang: @lang }
    end
  end
end
