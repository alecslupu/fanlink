RailsAdmin.config do |config|
  config.included_models.push("MarketingNotification")

  config.model "MarketingNotification" do
    list do
      fields :id,
             :person,
             :title,
             :body,
             :deep_link,
             :person_filter,
             :ttl_hours
    end

    show do
      fields :id,
             :person,
             :title,
             :body,
             :deep_link,
             :person_filter,
             :ttl_hours
    end

    edit do
      fields :title,
             :body,
             :deep_link,
             :person_filter,
             :ttl_hours
    end
  end
end
