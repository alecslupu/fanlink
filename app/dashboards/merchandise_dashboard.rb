require "administrate/base_dashboard"

class MerchandiseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    versions: Field::HasMany.with_options(class_name: "PaperTrail::Version"),
    id: Field::Number,
    name: Field::Text,
    description: Field::Text,
    price: Field::Text,
    purchase_url: Field::Text,
    picture: Field::Paperclip.with_options(blank_text: ""),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :description,
    :price,
    :picture
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :versions,
    :id,
    :name,
    :description,
    :price,
    :purchase_url,
    :picture,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :price,
    :purchase_url,
    :picture
  ].freeze

  # Overwrite this method to customize how merchandise are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(merchandise)
    "Merchandise ##{merchandise.name}"
  end
end
