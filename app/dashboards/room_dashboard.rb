require "administrate/base_dashboard"

class RoomDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    id: Field::Number,
    name: Field::Text,
    created_by: Field::BelongsTo.with_options(class_name: "Person"),
    status: Field::Enum,
    public: Field::Boolean,
    picture_id: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :product,
    :id,
    :name,
    :status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :id,
    :name,
    :status,
    :created_by,
    :status,
    :public,
    :picture_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :product,
    :name,
    :status,
    :picture_id,
  ].freeze

  # Overwrite this method to customize how rooms are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(room)
    "Room - #{room.name}"
  end
end
