# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Interest")
  config.model "Interest" do
    show do
      fields :id,
             :title,
             :order,
             :children
    end
    edit do
      field :title, :translated
      field :order
      field :children do
        def render
          bindings[:view].render partial: "rails_admin/main/form_nested_many_orderable", locals: {
            field: self, form: bindings[:form], field_order: :order_field,
          }
        end
      end
    end
    nested do
      field :title, :translated
      field :order
      exclude_fields :parent, :children
    end
    list do
      fields :id,
             :title,
             :order,
             :children
    end

    export do
      configure :name, :string
    end
  end
end
