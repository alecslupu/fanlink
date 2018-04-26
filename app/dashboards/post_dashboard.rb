require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  def permitted_attributes
    body_langs = []
    Post::LANGS.keys.each do |l|
      body_langs << "body_#{l}".to_sym
    end
    super + body_langs
  end

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    person: Field::BelongsTo,
    id: Field::Number,
    body: Field::Text,
    picture: Field::Paperclip.with_options(blank_text: ""),
    global: Field::Boolean,
    recommended: Field::Boolean,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    repost_interval: Field::Number,
    status: Field::Enum,
    priority: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    reported?: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :person,
    :body,
    :picture,
    :global,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
    :priority,
    :reported?,
    :created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :person,
    :id,
    :body,
    :picture,
    :global,
    :recommended,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
    :priority,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :body,
    :picture,
    :global,
    :recommended,
    :starts_at,
    :ends_at,
    :repost_interval,
    :status,
    :priority,
  ].freeze

  # Overwrite this method to customize how posts are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(post)
    if post.body.nil?
      "Post #{post.id} by #{post.person.username}"
    else
      "Post - #{post.body.truncate(22)}"
    end
  end
end
