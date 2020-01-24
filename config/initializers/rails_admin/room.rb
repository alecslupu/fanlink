RailsAdmin.config do |config|
  config.included_models.push("Room")
  config.model "Room" do
    configure :name_un do
    end
    list do
      scopes [:publics, nil, :privates]
      fields :id,
             :name_un,
             :picture,
             :status
    end
    edit do
      field :name, :translated
      field :description, :translated
      fields :name,
             :description,
             :picture,
             :status
    end
    show do
      fields :id,
             :name,
             :description,
             :picture,
             :status,
             :created_by,
             :status,
             :public
    end

    export do
      configure :name, :string
      configure :description, :string
    end
  end
end
