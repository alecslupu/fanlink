RailsAdmin.config do |config|
  config.included_models.push("Post")

  config.model Post do
    list do
      fields :person,
             :body,
             :picture,
             :global,
             :starts_at,
             :ends_at,
             :repost_interval,
             :status,
             :priority,
             :reported?,
             :created_at
    end
    show do
      fields :person,
             :id,
             :body,
             :picture,
             :global,
             :recommended,
             :starts_at,
             :ends_at,
             :repost_interval,
             :status,
             :priority
    end
    edit do
      fields :body,
             :picture,
             :global,
             :recommended,
             :starts_at,
             :ends_at,
             :repost_interval,
             :status,
             :priority
    end
  end
end
