RailsAdmin.config do |config|
  config.included_models.push("Post")

  config.model "Post" do
    configure :reported do
    end
    configure :id do
      label 'Post ID'
    end
    list do
      fields :person,
             :id,
             :body,
             :picture,
             :global,
             :starts_at,
             :ends_at,
             :repost_interval,
             :status,
             :priority
      field :reported do
        pretty_value do
          bindings[:object].reported?
        end
      end
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
