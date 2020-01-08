RailsAdmin.config do |config|
  config.included_models.push("Certificate")

  config.model "Certificate" do
    navigation_label "Courseware"

    configure :is_paid, :boolean do
      pretty_value do
        bindings[:object].is_paid?
      end

      export_value do
        bindings[:object].is_paid?.inspect
      end
    end

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
             :template_image
    end
    edit do
      fields :long_name,
             :short_name,
             :description,
             :room,
             :template_image
      field :certificate_order do
        help do
          "Last order set-up is: #{abstract_model.model.certificate_order_max_value}. You may set lower value, but setting an already used value, will result in error"
        end
      end
      fields :color_hex,
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
             :certificate_order
      field :is_paid, :boolean do
        #pretty_value do
        #  bindings[:object].is_paid?
        #end
      end
      fields :status,
             :certcourses
    end
    export do
      field :is_paid, :boolean do
        pretty_value do
          bindings[:object].is_paid?
        end

      end
    end
  end
end
