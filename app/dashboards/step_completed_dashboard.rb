require "administrate/base_dashboard"

class StepCompletedDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    step: Field::BelongsTo,
    person: Field::BelongsTo,
    id: Field::Number,
    quest_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    status: Field::Enum,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :step,
    :person,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :step,
    :person,
    :id,
    :quest_id,
    :created_at,
    :updated_at,
    :status,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :step,
    :person,
    :quest_id,
    :status,
  ].freeze

  # Overwrite this method to customize how step completed are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(step_completed)
  #   "StepCompleted ##{step_completed.id}"
  # end
end
