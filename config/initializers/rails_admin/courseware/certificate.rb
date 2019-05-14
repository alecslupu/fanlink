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
             :certificate_order,
             :status,
             :certcourses
    end
  end
end
# require "administrate/base_dashboard"
#
# class CertificateDashboard < Administrate::BaseDashboard
#   # ATTRIBUTE_TYPES
#   # a hash that describes the type of each of the model's fields.
#   #
#   # Each different type represents an Administrate::Field object,
#   # which determines how the attribute is displayed
#   # on pages throughout the dashboard.
#   ATTRIBUTE_TYPES = {
#     # room: Field::BelongsToSearch,
#     room: Field::BelongsToSearch,
#
#     certificate_certcourses: Field::HasMany,
#     certcourses: Field::HasMany,
#     person_certificates: Field::HasMany,
#     people: Field::HasMany,
#     id: Field::Number,
#     long_name: Field::String,
#     short_name: Field::String,
#     description: Field::Text,
#     certificate_order: Field::Number,
#     color_hex: Field::String,
#     status: Field::Enum,
#     is_free: Field::Boolean,
#     sku_ios: Field::String,
#     sku_android: Field::String,
#     validity_duration: Field::Number,
#     access_duration: Field::Number,
#     certificate_issuable: Field::Boolean,
#     created_at: Field::DateTime,
#     updated_at: Field::DateTime,
#     template_image: PaperclipField,
#   }.freeze
# end
