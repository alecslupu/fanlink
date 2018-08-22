require "administrate/base_dashboard"

class PortalAccessDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    person: Field::BelongsTo,
    person_id: Field::Hidden,
    id: Field::Number,
    post: AccessBooleansField,
    chat: AccessBooleansField,
    event: AccessBooleansField,
    merchandise: AccessBooleansField,
    user: AccessBooleansField,
    badge: AccessBooleansField,
    reward: AccessBooleansField,
    quest: AccessBooleansField,
    beacon: AccessBooleansField,
    reporting: AccessBooleansField,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :person,
    :id,
    :post,
    :chat,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :person,
    :id,
    :post,
    :chat,
    :event,
    :merchandise,
    :user,
    :badge,
    :reward,
    :quest,
    :beacon,
    :reporting,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :person,
    :post,
    :chat,
    :event,
    :merchandise,
    :user,
    :badge,
    :reward,
    :quest,
    :beacon,
    :reporting,
  ].freeze

  def permitted_attributes
    #,, create a class method for this
    super + [:post_read, :post_update, :post_delete, :chat_read, :chat_update, :chat_delete, :event_read, :event_update, :event_delete, :merchandise_read, :merchandise_update, :merchandise_delete, :user_read, :user_update, :user_delete, :badge_read, :badge_update, :badge_delete, :reward_read, :reward_update, :reward_delete, :quest_read, :quest_update, :quest_delete, :beacon_read, :beacon_update, :beacon_delete, :reporting_read, :reporting_update, :reporting_delete]
  end

  # Overwrite this method to customize how portal accesses are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(portal_access)
  #   "PortalAccess ##{portal_access.id}"
  # end
end
