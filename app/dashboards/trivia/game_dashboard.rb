require "administrate/base_dashboard"

class Trivia::GameDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    room: Field::BelongsTo,
    rounds: Field::HasMany.with_options(class_name: "Trivia::Round"),
    prizes: Field::HasMany.with_options(class_name: "Trivia::Prize"),
    leaderboards: Field::HasMany.with_options(class_name: "Trivia::GameLeaderboard"),
    id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    description: Field::Text,
    round_count: Field::Number,
    long_name: Field::String,
    short_name: Field::String,
    uuid: Field::String.with_options(searchable: false),
    status: Field::String.with_options(searchable: false),
    leaderboard_size: Field::Number,
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
    :room,
    :rounds,
    :prizes,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :room,
    :rounds,
    :prizes,
    :leaderboards,
    :id,
    :start_date,
    :end_date,
    :description,
    :round_count,
    :long_name,
    :short_name,
    :status,
    :leaderboard_size,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :product,
    :room,
    :rounds,
    :prizes,
    :leaderboards,
    :start_date,
    :description,
    :round_count,
    :long_name,
    :short_name,
    :status,
    :leaderboard_size,
  ].freeze

  # Overwrite this method to customize how games are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(game)
  #   "Trivia::Game ##{game.id}"
  # end
end
