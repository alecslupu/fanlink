require "administrate/base_dashboard"

class AnswerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    certcourse_page: Field::BelongsTo,
    id: Field::Number,
    description: Field::String,
    is_correct: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    question: Field::String,
    certcourse_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :certcourse_name,
    :question,
    :description,
    :is_correct,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :certcourse_page,
    :id,
    :description,
    :is_correct,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :certcourse_page,
    :description,
    :is_correct,
  ].freeze

  # Overwrite this method to customize how answers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(answer)
  #   "Answer ##{answer.id}"
  # end
end
