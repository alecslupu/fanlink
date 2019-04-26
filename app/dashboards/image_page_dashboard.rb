require "administrate/base_dashboard"

class ImagePageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    certcourse_page: Field::BelongsTo.with_options(order: :id),
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    image: PaperclipField,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  # COLLECTION_ATTRIBUTES = [
  #   :certcourse_page,
  #   :id,
  #   :created_at,
  #   :updated_at,
  # ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  # SHOW_PAGE_ATTRIBUTES = [
  #   :certcourse_page,
  #   :id,
  #   :image,
  #   :created_at,
  #   :updated_at,
  # ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # FORM_ATTRIBUTES = [
  #   :certcourse_page,
  #   :image,
  # ].freeze

  # Overwrite this method to customize how image pages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(image_page)
  #   "ImagePage ##{image_page.id}"
  # end
end
