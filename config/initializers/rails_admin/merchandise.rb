# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Merchandise")

  config.model "Merchandise" do
    list do
      fields :id,
             :name,
             :price,
             :priority,
             :picture
    end
    edit do
      field :name, :translated
      field :description, :translated
      fields :price,
             :priority,
             :purchase_url,
             :picture,
             :available
    end
    show do
      fields :id,
             :product,
             :name,
             :description,
             :price,
             :priority,
             :purchase_url,
             :picture,
             :available
    end

    export do
      configure :name, :string
      configure :description, :string
    end
  end
end
