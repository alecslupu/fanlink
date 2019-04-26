require "administrate/base_dashboard"

class PersonCertificateDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    person: Field::BelongsToSearch,
    certificate: Field::BelongsToSearch,
    id: Field::Number,
    full_name: Field::String,
    issued_date: Field::DateTime,
    validity_duration: Field::Number,
    amount_paid: Field::Number,
    currency: Field::String,
    fee_waived: Field::Boolean,
    purchased_waived_date: Field::DateTime,
    access_duration: Field::Number,
    purchased_order_id: Field::String,
    purchased_platform: Field::String.with_options(searchable: false),
    purchased_sku: Field::String,
    unique_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    issued_certificate_image_file_name: Field::String,
    issued_certificate_image_content_type: Field::String,
    issued_certificate_image_file_size: Field::Number,
    issued_certificate_image_updated_at: Field::DateTime,
    issued_certificate_pdf_file_name: Field::String,
    issued_certificate_pdf_content_type: Field::String,
    issued_certificate_pdf_file_size: Field::Number,
    issued_certificate_pdf_updated_at: Field::DateTime,
    receipt_id: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  # COLLECTION_ATTRIBUTES = [
  #   :person,
  #   :certificate,
  #   :id,
  #   :full_name,
  # ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  # SHOW_PAGE_ATTRIBUTES = [
  #   :person,
  #   :certificate,
  #   :id,
  #   :full_name,
  #   :issued_date,
  #   :validity_duration,
  #   :amount_paid,
  #   :currency,
  #   :fee_waived,
  #   :purchased_waived_date,
  #   :access_duration,
  #   :purchased_order_id,
  #   :purchased_platform,
  #   :purchased_sku,
  #   :unique_id,
  #   :created_at,
  #   :updated_at,
  #   :issued_certificate_image_file_name,
  #   :issued_certificate_image_content_type,
  #   :issued_certificate_image_file_size,
  #   :issued_certificate_image_updated_at,
  #   :issued_certificate_pdf_file_name,
  #   :issued_certificate_pdf_content_type,
  #   :issued_certificate_pdf_file_size,
  #   :issued_certificate_pdf_updated_at,
  #   :receipt_id,
  # ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # FORM_ATTRIBUTES = [
  #   :person,
  #   :certificate,
  #   :full_name,
  #   :issued_date,
  #   :validity_duration,
  #   :amount_paid,
  #   :currency,
  #   :fee_waived,
  #   :purchased_waived_date,
  #   :access_duration,
  #   :purchased_order_id,
  #   :purchased_platform,
  #   :purchased_sku,
  #   :unique_id,
  #   :issued_certificate_image_file_name,
  #   :issued_certificate_image_content_type,
  #   :issued_certificate_image_file_size,
  #   :issued_certificate_image_updated_at,
  #   :issued_certificate_pdf_file_name,
  #   :issued_certificate_pdf_content_type,
  #   :issued_certificate_pdf_file_size,
  #   :issued_certificate_pdf_updated_at,
  #   :receipt_id,
  # ].freeze

  # Overwrite this method to customize how person certificates are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(person_certificate)
  #   "PersonCertificate ##{person_certificate.id}"
  # end
end
