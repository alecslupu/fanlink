# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("PortalNotification")
  config.model "PortalNotification" do
    list do
      fields :body,
             :send_me_at,
             :sent_status,
             :created_at
    end
    show do
      fields :id,
              :body,
              :send_me_at,
              :sent_status,
              :created_at,
              :updated_at
    end
    edit do
      field :body, :translated
      fields :send_me_at, :sent_status
      field :trigger_admin_notification, :hidden do
        visible true
        formatted_value do
          bindings[:object].new_record? ? true : bindings[:object].trigger_admin_notification
        end
      end
      field :send_me_at, :hidden do
        visible true
        default_value do
          (Time.zone.now + 1.hour).beginning_of_hour
        end
      end
    end

    export do
      configure :body, :string
    end
  end
end
