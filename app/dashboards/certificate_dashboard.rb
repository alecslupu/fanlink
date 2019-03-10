require "administrate/base_dashboard"

class CertificateDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    room: Field::BelongsTo,
    certificate_certcourses: Field::HasMany,
    certcourses: Field::HasMany,
    person_certificates: Field::HasMany,
    people: Field::HasMany,
    id: Field::Number,
    long_name: Field::String,
    short_name: Field::String,
    description: Field::Text,
    certificate_order: Field::Number,
    color_hex: Field::String,
    status: Field::Enum,
    is_free: Field::Boolean,
    sku_ios: Field::String,
    sku_android: Field::String,
    validity_duration: Field::Number,
    access_duration: Field::Number,
    certificate_issuable: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    template_image: PaperclipField,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :short_name,
    :certificate_order,
    :status,
    :certcourses,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
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
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :long_name,
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
    :certificate_issuable,
  ].freeze

  # Overwrite this method to customize how certificates are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(certificate)
  #   "Certificate ##{certificate.id}"
  # end
end
