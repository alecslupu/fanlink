RailsAdmin.config do |config|
  config.included_models.push("Certcourse")

  config.model "Certcourse" do
    parent "Certificate"

    show do
      fields :id,
             :long_name,
             :short_name,
             :description,
             :color_hex,
             :status,
             :duration,
             :is_completed,
             :copyright_text,
             :certcourse_pages
    end
    edit do
      fields :long_name, :short_name, :description, :color_hex, :status, :duration, :is_completed, :copyright_text

      field :certcourse_pages do
        def render
          bindings[:view].render partial: "rails_admin/main/form_nested_many_orderable", locals: {
            field: self, form: bindings[:form], field_order: :certcourse_page_order_field,
          }
        end
      end
    end
    list do
      fields :id, :short_name, :status, :certificate_certcourses, :certificates
    end
  end
end
