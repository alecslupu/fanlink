require "administrate/base_dashboard"

class CertcoursePageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    certcourse: Field::BelongsTo,
    quiz_type: Field::Select.with_options(collection: CertcoursePage.new.quiz_type),
    quiz_page: Field::HasOne,
    video_page: Field::HasOne,
    image_page: Field::HasOne,
    id: Field::Number,
    certcourse_page_order: Field::Number,
    duration: Field::Number,
    background_color_hex: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :certcourse,
    :quiz_page,
    :video_page,
    :image_page,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :certcourse,
    :quiz_page,
    :video_page,
    :image_page,
    :id,
    :certcourse_page_order,
    :duration,
    :background_color_hex,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :certcourse,
    :quiz_type,
    :certcourse_page_order,
    :duration,
    :background_color_hex,
  ].freeze

  # Overwrite this method to customize how certcourse pages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(certcourse_page)
  #   "CertcoursePage ##{certcourse_page.id}"
  # end
end