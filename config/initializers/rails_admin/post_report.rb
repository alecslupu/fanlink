RailsAdmin.config do |config|
  config.included_models.push("PostReport")
  config.model "PostReport" do
    configure :post_body do
      pretty_value do
        Post.find(bindings[:object].post_id).body
      end
    end
    list do
      fields :post,
             :person,
             :status,
             :post_body
    end
    show do
      fields :id,
             :post,
             :person,
             :reason,
             :status,
             :updated_at
    end
  end
end
