require "administrate/base_dashboard"

class QuestDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    steps: Field::HasMany,
    quest_completions: Field::HasMany,
    id: Field::Number,
    event_id: Field::Number,
    name_text_old: Field::Text,
    internal_name: Field::Text,
    description_text_old: Field::Text,
    status: Field::Enum,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    picture: Field::Paperclip.with_options(blank_text: ""),
    picture_meta: Field::Text,
    name: Field::String.with_options(searchable: false),
    description: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :product,
    :steps,
    :quest_completions,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :product,
    :steps,
    :quest_completions,
    :id,
    :event_id,
    :internal_name,
    :status,
    :starts_at,
    :ends_at,
    :created_at,
    :updated_at,
    :picture,
    :picture_meta,
    :name,
    :description,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :product,
    :event_id,
    :internal_name,
    :status,
    :starts_at,
    :ends_at,
    :picture,
    :name,
    :description,
  ].freeze

  # Overwrite this method to customize how quests are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(quest)
  #   "Quest ##{quest.id}"
  # end
end
