require "administrate/base_dashboard"

class Trivia::GameDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    trivia_packages: Field::HasMany.with_options(class_name: "Trivia::Package"),
    trivia_game_leaderboards: Field::HasMany.with_options(class_name: "Trivia::GameLeaderboard"),
    product: Field::BelongsToSearch.with_options(class_name: "Product"),
    id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    name: Field::String,
    description: Field::Text,
    package_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :trivia_packages,
    # :trivia_game_leaderboards,
    :id,
    :start_date,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :trivia_packages,
    # :trivia_game_leaderboards,
    :id,
    :start_date,
    :end_date,
    :name,
    :description,
    :package_count,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :trivia_packages,
    # :trivia_game_leaderboards,
    :product,
    :start_date,
    :end_date,
    :name,
    :description,
    # :package_count,
  ].freeze

  # Overwrite this method to customize how games are displayed
  # across all pages of the admin dashboard.
  # def display_resource(game)
  #   "Trivia::Game ##{game.id}"
  # end
end
