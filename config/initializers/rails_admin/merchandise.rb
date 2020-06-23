# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Merchandise')

  config.included_models.push('Merchandise::Translation')

  config.model 'Merchandise::Translation' do
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
  config.model 'Merchandise' do
    configure :translations, :globalize_tabs

    list do
      field :id
      field :name do
        searchable [{merchandise_translations: :name }]
        queryable true
        filterable true
      end
      field :description do
        visible false
        searchable [{merchandise_translations: :description }]
        queryable true
        filterable true
      end

      fields :price,
             :priority,
             :picture
    end
    edit do
      fields :translations,
             :price,
             :priority,
             :purchase_url,
             :picture,
             :available
    end
    show do
      fields :id,
             :product,
             :translations,
             :price,
             :priority,
             :purchase_url,
             :picture,
             :available
    end

    export do
    end
  end
end
