RailsAdmin.config do |config|
  config.included_models.push('Reward')

  config.included_models.push('Reward::Translation')

  config.model 'Reward::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :name
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :name
    end
  end

  config.model 'Reward' do
    configure :translations, :globalize_tabs

    list do
      fields :id,
             :translations,
             :internal_name,
             :points

      field :name do
        visible false
        searchable [{reward_translations: :name } ]
        queryable true
        filterable true
      end
    end
    edit do
      fields :translations,
             :internal_name,
             :points
    end
    show do
      fields :id,
             :translations,
             :internal_name,
             :points
    end

    export do

    end
  end
end
