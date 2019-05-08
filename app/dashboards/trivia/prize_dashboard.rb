require "administrate/base_dashboard"

class Trivia::PrizeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    game: Field::BelongsTo.with_options(class_name: "Trivia::Game"),
    id: Field::Number,
    trivia_game: Field::BelongsTo.with_options(class_name: "Trivia::Game"),
    status: Field::Enum,
    description: Field::Text,
    position: Field::Number,
    photo_file_name: Field::String,
    photo_file_size: Field::String,
    photo_content_type: Field::String,
    photo_updated_at: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :game,
    :id,
    :trivia_game_id,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :game,
    :id,
    :trivia_game,
    :status,
    :description,
    :position,
    :photo_file_name,
    :photo_file_size,
    :photo_content_type,
    :photo_updated_at,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :game,
    :trivia_game,
    :status,
    :description,
    :position,
    :photo_file_name,
    :photo_file_size,
    :photo_content_type,
    :photo_updated_at,
  ].freeze

  # Overwrite this method to customize how prizes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(prize)
  #   "Trivia::Prize ##{prize.id}"
  # end
end
