RailsAdmin.config do |config|
  config.included_models.push("Post")

  config.model "Post" do
    configure :reported do
    end
    configure :id do
      label "Post ID"
    end
    list do
      field :person do
        column_width 30
      end
      field :body do
        column_width 150
        pretty_value do
          bindings[:object].body_buffed("en")
        end
      end
      field :picture do
        column_width 30
      end
      field :global do
        column_width 30
      end
      field :starts_at do
        column_width 30
      end
      field :ends_at do
        column_width 30
      end
      field :repost_interval do
        column_width 30
      end
      field :status do
        column_width 30
      end
      field :priority do
        column_width 30
      end
      field :reported do
        column_width 30
        pretty_value do
          bindings[:object].reported?
        end
      end
      field :created_at do
        column_width 60
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
