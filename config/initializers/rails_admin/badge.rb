# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Badge')

  config.included_models.push('Badge::Translation')

  config.model 'Badge::Translation' do
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
  config.model 'Badge' do
    configure :translations, :globalize_tabs

    list do
      fields :id,
             :action_type

      field :name do
        visible false
        searchable [{badge_translations: :name }]
        queryable true
        filterable true
      end
      field :description do
        visible false
        searchable [{badge_translations: :description }]
        queryable true
        filterable true
      end

      fields :internal_name,
             :picture
    end
    edit do
      fields :translations,
             :internal_name,
             :picture,
             :action_type,
             :action_requirement,
             :point_value,
             :issued_from,
             :issued_to
    end
    show do
      fields :id,
             :action_type,
             :translations,
             :internal_name,
             :action_requirement,
             :point_value,
             :picture,
             :issued_from,
             :issued_to
    end

    export do
    end
  end
end
