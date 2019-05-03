RailsAdmin.config do |config|
  config.included_models.push("Event")

  config.model "Event" do

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
             :ticket_url,
             :place_identifier
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
