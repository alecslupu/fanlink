require "administrate/base_dashboard"

class PersonCertcourseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    person: Field::BelongsTo,
    certcourse: Field::BelongsTo,
    id: Field::Number,
    last_completed_page_id: Field::Number,
    is_completed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :person,
    :certcourse,
    :id,
    :last_completed_page_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :person,
    :certcourse,
    :id,
    :last_completed_page_id,
    :is_completed,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :person,
    :certcourse,
    :last_completed_page_id,
    :is_completed,
  ].freeze

  # Overwrite this method to customize how person certcourses are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(person_certcourse)
  #   "PersonCertcourse ##{person_certcourse.id}"
  # end
end
