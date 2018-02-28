require "administrate/base_dashboard"

class MessageReportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    message: Field::BelongsTo,
    person: Field::BelongsTo,
    versions: Field::HasMany.with_options(class_name: "PaperTrail::Version"),
    id: Field::Number,
    reason: Field::Text,
    status: Field::Enum,
    reporter: Field::String,
    poster: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :message,
    :poster,
    :reporter,
    :reason,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :message,
    :poster,
    :reporter,
    :reason,
    :status,
    :updated_at,
  ].freeze


  # Overwrite this method to customize how message reports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(message_report)
  #   "MessageReport ##{message_report.id}"
  # end
end
