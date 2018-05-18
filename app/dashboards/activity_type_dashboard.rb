require "administrate/base_dashboard"

class ActivityTypeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    quest_activity: Field::BelongsTo.with_options(foreign_key: "activity_id", ),
    id: Field::Number,
    activity_id: Field::Number,
    type: Field::Enum,
    value: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :quest_activity,
    :id,
    :activity_id,
    :type,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :quest_activity,
    :id,
    :activity_id,
    :type,
    :value,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :quest_activity,
    :activity_id,
    :type,
    :value,
  ].freeze

  # Overwrite this method to customize how activity types are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(activity_type)
  #   "ActivityType ##{activity_type.id}"
  # end
end