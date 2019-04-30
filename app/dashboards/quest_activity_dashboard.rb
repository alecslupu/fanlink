require "administrate/base_dashboard"

class QuestActivityDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    activity_types: Field::HasMany.with_options(foreign_key: "activity_id",),
    step: Field::BelongsTo,
    id: Field::Number,
    deleted: Field::Boolean,
    picture: Field::Paperclip.with_options(blank_text: ""),
    hint: Field::String.with_options(searchable: false),
    description: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :step,
    :activity_types,
    :description,
    :hint,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :activity_types,
    :step,
    :id,
    :deleted,
    :picture,
    :hint,
    :description,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :activity_types,
    :step,
    :deleted,
    :picture,
    :hint,
    :description,
  ].freeze

  # Overwrite this method to customize how quest activities are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(quest_activity)
  #   "QuestActivity ##{quest_activity.id}"
  # end
end
