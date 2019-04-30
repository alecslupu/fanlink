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
             :copyright_text
    end
    edit do
      fields :long_name, :short_name, :description, :color_hex, :status, :duration, :is_completed, :copyright_text
    end
    list do
      fields :id, :short_name, :status, :certificate_certcourses, :certificates
    end
  end
end