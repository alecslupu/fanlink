RailsAdmin.config do |config|
  config.included_models.push("Certcourse")

  config.model "Certcourse" do
    parent "Certificate"

    show do
      fields :certificate_certcourses, :certificates, :certcourse_pages, :id, :long_name, :short_name, :description
      fields :color_hex, :status, :duration, :is_completed, :copyright_text, :created_at, :updated_at
    end
    edit do
      fields :long_name, :short_name, :description, :color_hex, :status, :duration, :is_completed, :copyright_text
    end
    list do
      fields :id, :short_name, :status, :certificate_certcourses, :certificates
    end
  end
end
