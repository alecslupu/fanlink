# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('PortalNotification')
  config.included_models.push('PortalNotification::Translation')

  config.model 'PortalNotification::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :body
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :body
    end
  end
  config.model 'PortalNotification' do
    configure :translations, :globalize_tabs

    list do
      field :body do
        searchable [{portal_notification_translations: :body } ]
        queryable true
        filterable true
      end
      fields :send_me_at,
             :sent_status,
             :created_at

    end
    show do
      fields :id,
              :translations,
              :send_me_at,
              :sent_status,
              :created_at,
              :updated_at
    end
    edit do
      field :send_me_at do
        visible true
        default_value { (Time.zone.now + 1.hour).beginning_of_hour }
      end
      fields :sent_status, :translations
      field :trigger_admin_notification, :hidden do
        visible true
        formatted_value do
          bindings[:object].new_record? ? true : bindings[:object].trigger_admin_notification
        end
      end
    end

    export do
      configure :body, :string
    end
  end
end
