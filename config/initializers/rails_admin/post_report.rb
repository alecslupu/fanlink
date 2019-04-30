RailsAdmin.config do |config|
  config.included_models.push("PostReport")
  config.model "PostReport" do
    list do
      fields :post,
             :person,
             :status
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
