Administrate::Engine.add_javascript("admin/events")
Administrate::Engine.add_javascript("admin/message_reports")
Administrate::Engine.add_javascript("admin/post_reports")
Administrate::Engine.add_javascript("admin/posts")
Administrate::Engine.add_stylesheet("admin/custom")
Administrate::Engine.add_stylesheet("admin/google_places")

require "administrate/field/boolean"

Administrate::Field::Boolean.class_eval do
  def to_s
    data ? "Yes" : "No"
  end
end
