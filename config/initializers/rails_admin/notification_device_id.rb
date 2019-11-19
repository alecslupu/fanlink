RailsAdmin.config do |config|
  config.included_models.push("NotificationDeviceId")

  config.model "NotificationDeviceId" do
    configure :person do
      pretty_value do
        Person.find(bindings[:object].person_id)
      end
    end
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
