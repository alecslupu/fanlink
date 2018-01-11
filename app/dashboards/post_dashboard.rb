require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    person: Field::BelongsTo,
    id: Field::Number,
    title: Field::Text,
    body: Field::Text,
    picture_id: Field::Text,
    global: Field::Boolean,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    repost_interval: Field::Number,
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
    :person,
    :title,
    :body,
    :global,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
    :created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :person,
    :id,
    :title,
    :body,
    :picture_id,
    :global,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :body,
    :picture_id,
    :global,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
  ].freeze

  # Overwrite this method to customize how posts are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(post)
    "Post - #{(post.title || post.body).truncate(14)}"
  end
end
