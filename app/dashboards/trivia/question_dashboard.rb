require "administrate/base_dashboard"

class Trivia::QuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    trivia_package: Field::BelongsTo.with_options(class_name: "Trivia::QuestionPackage"),
    trivia_available_answers: Field::HasMany.with_options(class_name: "Trivia::AvailableAnswer"),
    trivia_answers: Field::HasMany.with_options(class_name: "Trivia::Answer"),
    id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    complexity: Field::Number,
    time_limit: Field::Number,
    type: Field::String,
    question_order: Field::Number,
    status: Field::Enum,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :trivia_package,
    :trivia_available_answers,
    :trivia_answers,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :trivia_package,
    :trivia_available_answers,
    :trivia_answers,
    :id,
    :start_date,
    :end_date,
    :complexity,
    :time_limit,
    :type,
    :question_order,
    :status,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :trivia_package,
    :trivia_available_answers,
    :trivia_answers,
    :start_date,
    :end_date,
    :complexity,
    :time_limit,
    :type,
    :question_order,
    :status,
  ].freeze

  # Overwrite this method to customize how questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(question)
  #   "Trivia::Question ##{question.id}"
  # end
end
