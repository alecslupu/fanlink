RailsAdmin.config do |config|
  config.included_models.push("Certificate")

  config.model "Certificate" do
    navigation_label "Courseware"

    show do
      fields :id,
             :long_name,
             :short_name,
             :description,
             :certificate_certcourses,
             :certificate_order,
             :color_hex,
             :status,
             :is_free,
             :sku_ios,
             :sku_android,
             :room,
             :validity_duration,
             :access_duration,
             :certificate_issuable,
             :template_image,
             :created_at,
             :updated_at
    end
    edit do
      fields :long_name,
             :short_name,
             :description,
             :room,
             :template_image,
             :certificate_order,
             :color_hex,
             :status,
             :is_free,
             :sku_ios,
             :sku_android,
             :validity_duration,
             :access_duration,
             :certificate_issuable
    end
    list do
      fields :id,
             :short_name,
             :certificate_order,
             :status,
             :certcourses
    end
  end
end
