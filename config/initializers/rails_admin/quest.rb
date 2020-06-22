RailsAdmin.config do |config|
  config.included_models.push('Quest')

  config.included_models.push('Quest::Translation')

  config.model 'Quest::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end

    include_fields :locale, :name, :description
    #
    edit do
      field :name do
        help do
          I18n.locale ==  bindings[:object].locale ? 'Required' : 'Optional'
        end
      end
      field :description do
        help do
          I18n.locale ==  bindings[:object].locale ? 'Required' : 'Optional'
        end
      end
    end
    export do
      fields :locale, :name, :description
    end
  end
  config.model 'Quest' do
    configure :translations, :globalize_tabs

    list do
      fields :id

      field :name do
        visible false
        searchable [{quest_translations: :name }]
        queryable true
        filterable true
      end
      field :description do
        visible false
        searchable [{quest_translations: :description }]
        queryable true
        filterable true
      end

      fields :internal_name,
             :picture
    end
    edit do
      fields :translations,
             :internal_name,
             :starts_at,
             :picture
    end
    show do
      fields :id,
             :translations,
             :internal_name,
             :starts_at,
             :picture
    end

    export do
    end
  end
end
