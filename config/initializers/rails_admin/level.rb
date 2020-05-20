# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Level")

  config.included_models.push("Level::Translation")

  config.model 'Level::Translation' do
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

  config.model "Level" do
    configure :translations, :globalize_tabs

    list do
      fields :id,
             :translations,
             :internal_name,
             :picture,
             :points

      field :name do
        visible false
        searchable [{level_translations: :name } ]
        queryable true
        filterable true
      end
      field :description do
        visible false
        searchable [{level_translations: :description } ]
        queryable true
        filterable true
      end
    end
    edit do
      fields :translations,
             :internal_name,
             :points,
             :picture
    end
    show do
      fields :id,
             :translations,
             :internal_name,
             :points,
             :picture
    end

    export do

    end
  end
end
