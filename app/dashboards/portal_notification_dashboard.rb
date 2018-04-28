require "administrate/base_dashboard"

class PortalNotificationDashboard < Administrate::BaseDashboard
  # def permitted_attributes
  #   body_langs = []
  #   Post::LANGS.keys.each do |l|
  #     body_langs << "body_#{l}".to_sym
  #   end
  #   super + body_langs
  # end

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      person: Field::BelongsTo,
      id: Field::Number,
      body: TranslatedField,
      send_me_at: Field::DateTime,
      status: Field::Enum,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :person,
      :body,
      :send_me_at,
      :status,
      :created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      :person,
      :id,
      :body,
      :send_me_at,
      :status,
      :created_at,
      :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
       :body,
       :send_me_at,
       :status
   ].freeze

  def display_resource(portal_notification)
    "Portal Notification - #{portal_notification.body.truncate(22)}"
  end
end
