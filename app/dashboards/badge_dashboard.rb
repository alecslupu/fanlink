require "administrate/base_dashboard"

class BadgeDashboard < Administrate::BaseDashboard
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
    internal_name: Field::Text,
    picture_id: Field::Text,
    action_type: Field::BelongsTo,
    action_requirement: Field::Number,
    point_value: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :product,
    :id,
    :action_type,
    :name,
    :internal_name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :id,
    :action_type,
    :name,
    :internal_name,
    :picture_id,
    :action_requirement,
    :point_value,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :product,
    :name,
    :internal_name,
    :picture_id,
    :action_type,
    :action_requirement,
    :point_value
  ].freeze

  # Overwrite this method to customize how badges are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(badge)
    "Badge - #{badge.internal_name}"
  end
end
