RailsAdmin.config do |config|
  config.included_models.push("NotificationDeviceId")

  config.model "NotificationDeviceId" do
    list do
      fields :id,
             :person,
             :not_registered,
             :device_identifier,
             :device_type
    end

    show do
      fields :id,
             :person,
             :not_registered,
             :device_identifier,
             :device_type
    end
  end
end
