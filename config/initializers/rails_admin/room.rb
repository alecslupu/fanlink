RailsAdmin.config do |config|
  config.included_models.push("Room")
  config.included_models.push("Room::Translation")

  config.model 'Room::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :name, :description
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :name, :description
    end
  end
  config.model "Room" do
    configure :translations, :globalize_tabs

    configure :name do
    end
    list do
      scopes [:publics, nil, :privates]
      field :id
      field :name do
        searchable [{room_translations: :name } ]
        queryable true
        filterable true
      end
      field :description do
        visible false
        searchable [{room_translations: :description } ]
        queryable true
        filterable true
      end

      fields  :picture,
             :status
      field :subscribers do
      end
    end
    edit do
      fields :translations,
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
             :translations,
             :picture,
             :status,
             :created_by,
             :status,
             :public
    end

    export do
    end
  end
end
