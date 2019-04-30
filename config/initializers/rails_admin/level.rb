RailsAdmin.config do |config|
  config.included_models.push("Level")

  config.model "Level" do

    list do
      fields :id,
             :name,
             :internal_name,
             :picture,
             :points
    end
    edit do
      field :name, :translated
      field :description, :translated
      fields :internal_name,
             :points,
             :picture
    end
    show do
      fields :id,
             :name,
             :internal_name,
             :description,
             :points,
             :picture
    end
  end
end
