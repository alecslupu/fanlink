require "administrate/base_dashboard"

class PersonDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    id: Field::Number,
    name: Field::Text.with_options(searchable: true),
    username: Field::Text.with_options(searchable: true),
    email: Field::Text.with_options(searchable: true),
    picture: Field::Paperclip.with_options(blank_text: ""),
    role: Field::Enum.with_options(collection_method: :roles_for_select),
    do_not_message_me: Field::Boolean,
    pin_messages_from: Field::Boolean,
    auto_follow: Field::Boolean,
    product_account: Field::Boolean,
    chat_banned: Field::Boolean,
    level_earned: Field::BelongsTo::with_options(class_name: "Level"),
    badges: Field::HasMany,
    facebookid: Field::Text,
    facebook_picture_url: Field::Text,
    crypted_password: Field::Text,
    salt: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    password: PasswordField,
    notification_device_ids: Field::HasMany
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :username,
    :email,
    :name,
    :picture,
    :role,
    :created_at,
    :notification_device_ids
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :username,
    :email,
    :name,
    :picture,
    :role,
    :do_not_message_me,
    :pin_messages_from,
    :auto_follow,
    :chat_banned,
    :product_account,
    :facebookid,
    :facebook_picture_url,
    :created_at,
    :updated_at,
    :level_earned,
    :badges
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :username,
    :email,
    :name,
    :picture,
    :role,
    :do_not_message_me,
    :pin_messages_from,
    :auto_follow,
    :chat_banned,
    :product_account,
    :password
  ].freeze

  # Overwrite this method to customize how people are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(person)
    person.name
  end
end
