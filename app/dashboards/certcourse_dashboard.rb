require "administrate/base_dashboard"

class CertcourseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    certificate_certcourses: Field::HasMany,
    certificates: Field::HasMany,
    person_certcourses: Field::HasMany,
    people: Field::HasMany,
    certcourse_pages: Field::HasMany,
    id: Field::Number,
    long_name: Field::String,
    short_name: Field::String,
    description: Field::Text,
    color_hex: Field::String,
    status: Field::String.with_options(searchable: false),
    duration: Field::Number,
    is_completed: Field::Boolean,
    copyright_text: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  # COLLECTION_ATTRIBUTES = [
  #   :id,
  #   :short_name,
  #   :certificate_certcourses,
  #   :certificates,
  # ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  # SHOW_PAGE_ATTRIBUTES = [
  #   :certificate_certcourses,
  #   :certificates,
  #   :certcourse_pages,
  #   :id,
  #   :long_name,
  #   :short_name,
  #   :description,
  #   :color_hex,
  #   :status,
  #   :duration,
  #   :is_completed,
  #   :copyright_text,
  #   :created_at,
  #   :updated_at,
  # ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # FORM_ATTRIBUTES = [
  #   :long_name,
  #   :short_name,
  #   :description,
  #   :color_hex,
  #   :status,
  #   :duration,
  #   :is_completed,
  #   :copyright_text,
  # ].freeze

  # Overwrite this method to customize how certcourses are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(certcourse)
    "#{certcourse.short_name}"
  end
end
