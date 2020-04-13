class Migration::PortalNotificationJob < ApplicationJob
  queue_as :migration

  def perform(portal_notification_id)
    langs = ["en", "es", "ro"]
    portal_notification = PortalNotification.find(portal_notification_id)
    langs.each do |value|
      next if portal_notification.untranslated_body[value].nil?
      next if portal_notification.untranslated_body[value].empty?
      next if portal_notification.untranslated_body[value] == '-'

      I18n.locale = value
      portal_notification.set_translations({ "#{value}": { body: portal_notification.untranslated_body[value] } })
      # level.save!
    end
    unless PortalNotification.with_translations('en').where(id: portal_notification.id).first.present?
      next if portal_notification.untranslated_body["un"].nil?
      next if portal_notification.untranslated_body["un"].empty?
      I18n.locale = "en"
      portal_notification.set_translations({ en: { body: portal_notification.untranslated_body["un"] } })
      # level.save!
    end
  end
end
