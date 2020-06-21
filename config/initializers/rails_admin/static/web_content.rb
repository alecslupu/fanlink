# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push('Static::WebContent')

  config.included_models.push('Static::WebContent::Translation')

  config.model 'Static::WebContent::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :content
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :title, :content
    end
  end
  config.model 'Static::WebContent' do
    configure :translations, :globalize_tabs

    list do
      fields :id,
             :translations,
             :slug
    end

    edit do
      fields :id,
             :translations
    end

    show do
      fields :id,
             :translations,
             :slug
    end

    export do
    end
  end
end
