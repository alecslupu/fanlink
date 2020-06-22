# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Interest')
  config.included_models.push('Interest::Translation')

  config.model 'Interest::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :title
    end
  end
  config.model 'Interest' do
    configure :translations, :globalize_tabs

    show do
      fields :id,
             :translations,
             :order,
             :children
    end
    edit do
      field :translations
      field :order
      field :children do
        def render
          bindings[:view].render partial: 'rails_admin/main/form_nested_many_orderable', locals: {
            field: self, form: bindings[:form], field_order: :order_field
          }
        end
      end
    end
    nested do
      fields :translations,
             :order
      exclude_fields :parent, :children
    end
    list do
      fields :id,
             :order

      field :title do
        searchable [{interest_translations: :title } ]
        queryable true
        filterable true
      end
      field :children
    end

    export do
      configure :name, :string
    end
  end
end
