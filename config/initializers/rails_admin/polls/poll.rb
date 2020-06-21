# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Poll')

  config.included_models.push('Poll::Translation')

  config.model 'Poll::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :description
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :description
    end
  end

  config.model 'Poll' do
    parent 'Post'
    configure :translations, :globalize_tabs

    show do
      fields :id,
             :translations,
             :poll_type,
             :poll_type_id,
             :duration,
             :start_date,
             :end_date,
             :poll_status,
             :duration
    end

    edit do
      field :poll_type
      field :poll_type_id, :integer do
        label 'Post id'
      end
      fields :start_date,
             :end_date,
             :duration,
             :poll_status,
             :poll_options,
             :translations
    end

    list do

      scopes [ nil, :inactive, :active, :disabled ]

      fields :id, :poll_type, :poll_type_id, :start_date, :end_date, :duration, :poll_status

      field :description do
        visible false
        searchable [{poll_translations: :description } ]
        queryable true
        filterable true
      end

    end
  end
end
