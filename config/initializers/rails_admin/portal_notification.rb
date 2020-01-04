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
    end

    export do
      configure :body, :string
    end
  end
end
