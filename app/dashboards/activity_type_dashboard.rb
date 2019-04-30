require "administrate/base_dashboard"

class ActivityTypeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    quest_activity: Field::BelongsTo.with_options(foreign_key: "activity_id"),
    id: Field::Number,
    activity_id: Field::Number,
    atype: Field::Enum,
    value: Field::Text,
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
    :atype,
    :value,
    :quest_activity,
    :created_at,
    :updated_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :quest_activity,
    :atype,
    :value,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :quest_activity,
    :atype,
    :value,
  ].freeze

  # Overwrite this method to customize how activity types are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(activity_type)
  #   "ActivityType ##{activity_type.id}"
  # end
end
