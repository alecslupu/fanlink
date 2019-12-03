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
      field :title, :translated
      fields :parent_id,
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
