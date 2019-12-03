RailsAdmin.config do |config|
  config.included_models.push("Interest")
  config.model "Interest" do
    configure :children do
    end

    show do
      fields :id,
             :title,
             :order,
             :children
    end
    edit do
      field :title, :translated
      field :order
      # field :children do
      # end
      field :children do
        def render
          bindings[:view].render partial: "rails_admin/main/form_nested_many_orderable", locals: {
            field: self, form: bindings[:form], field_order: :interest_order_field,
          }
        end
      end
    end
    list do
      fields :id,
             :title,
             :order,
             :children
    end

  end
end
