require "administrate/base_dashboard"

class Trivia::RoundDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    game: Field::BelongsTo.with_options(class_name: "Trivia::Game"),
    questions: Field::HasMany.with_options(class_name: "Trivia::Question"),
    id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    question_count: Field::Number,
    leaderboard_size: Field::Number,
    status: Field::Enum,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    complexity: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :game,
    :questions,
    :id,
    :start_date,
    :complexity
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :game,
    :questions,
    :id,
    :start_date,
    :end_date,
    :question_count,
    :leaderboard_size,
    :status,
    :complexity,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :game,
    :questions,
    :start_date,
    :complexity,
    :question_count,
    :leaderboard_size,
    :status,
  ].freeze

  # Overwrite this method to customize how packages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(package)
  #   "Trivia::QuestionPackage ##{package.id}"
  # end
end
