RailsAdmin.config do |config|
  config.included_models.push("Interest")

  config.model "Interest" do

    list do
      fields :id,
             :parent_id,
             :title,
             :order
    end
    edit do
      fields :parent_id,
             :title,
             :order
    end
    show do
      fields :id,
             :parent_id,
             :title,
             :order
    end
  end
end
