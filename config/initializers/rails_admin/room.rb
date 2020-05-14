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

      field :public, :hidden do
        visible true
        formatted_value do
          bindings[:object].new_record? ? true : bindings[:object].public?
        end
      end

      field :created_by_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end

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
