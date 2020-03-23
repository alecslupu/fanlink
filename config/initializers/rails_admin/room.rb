RailsAdmin.config do |config|
  config.included_models.push("Room")
  config.model "Room" do
    configure :name_un do
    end
    # configure :subscribers do
    #   hide do
    #     bindings[:object].private?
    #   end
    # end
    list do
      scopes [:publics, nil, :privates]
      fields :id,
             :name_un,
             :picture,
             :status
      field :subscribers do
      end
    end
    edit do
      field :name, :translated
      field :description, :translated
      fields :name,
             :description,
             :picture,
             :status
      field :subscribers do
        label "Owners"
        hide do
          bindings[:object].private?
        end
      end
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
