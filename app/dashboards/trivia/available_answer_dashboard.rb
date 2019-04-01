require "administrate/base_dashboard"

class Trivia::AvailableAnswerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    trivia_question: Field::BelongsTo.with_options(class_name: "Trivia::Question"),
    id: Field::Number,
    trivia_question_id: Field::Number,
    name: Field::String,
    hint: Field::String,
    is_correct: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :trivia_question,
    :id,
    :trivia_question_id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :trivia_question,
    :id,
    :trivia_question_id,
    :name,
    :hint,
    :is_correct,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :trivia_question,
    :trivia_question_id,
    :name,
    :hint,
    :is_correct,
  ].freeze

  # Overwrite this method to customize how available answers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(available_answer)
  #   "Trivia::AvailableAnswer ##{available_answer.id}"
  # end
end
