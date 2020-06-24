# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Event')

  config.model 'Event' do
    list do
      fields :id,
             :name,
             :starts_at,
             :ticket_url
    end
    edit do
      fields :name,
             :description,
             :starts_at,
             :ends_at,
             :ticket_url
      field :place_identifier, :string do
        def render
          google_key = ENV['GOOGLE_PLACES_KEY']
          bindings[:view].render partial: 'rails_admin/main/places', locals: {
            field: self, form: bindings[:form], place_info: bindings[:object].place_info,
            url: "https://maps.googleapis.com/maps/api/js?key=#{google_key}&libraries=places&callback=initMap"
          }
        end
      end
    end
    show do
      fields :id,
             :name,
             :description,
             :starts_at,
             :ends_at,
             :ticket_url,
             :place_identifier
    end
  end
end
