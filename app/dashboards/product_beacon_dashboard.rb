require "administrate/base_dashboard"

class ProductBeaconDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    quest_activity: Field::HasOne,
    id: Field::Number,
    beacon_pid: Field::Text,
    attached_to: Field::Number,
    deleted: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    uuid: Field::String.with_options(searchable: false),
    lower: Field::Number,
    upper: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :product,
    :quest_activity,
    :versions,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :quest_activity,
    :id,
    :beacon_pid,
    :attached_to,
    :deleted,
    :created_at,
    :updated_at,
    :uuid,
    :lower,
    :upper,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :product,
    :beacon_pid,
    :attached_to,
    :deleted,
    :uuid,
    :lower,
    :upper,
  ].freeze

  # Overwrite this method to customize how product beacons are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(product_beacon)
  #   "ProductBeacon ##{product_beacon.id}"
  # end
end
