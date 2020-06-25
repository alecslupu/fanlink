module Migration
  module Translation
    class PortalNotificationJob < ApplicationJob
      queue_as :migration

      def perform(portal_notification_id)
        langs = ['en', 'es', 'ro']
        portal_notification = PortalNotification.find(portal_notification_id)
        langs.each do |value|
          return if portal_notification.untranslated_body[value].nil?
          return if portal_notification.untranslated_body[value].empty?
          return if portal_notification.untranslated_body[value] == '-'

          I18n.locale = value
          portal_notification.set_translations({ "#{value}": { body: portal_notification.untranslated_body[value] } })
          # level.save!
        end
        unless PortalNotification.with_translations('en').where(id: portal_notification.id).first.present?
          return if portal_notification.untranslated_body['un'].nil?
          return if portal_notification.untranslated_body['un'].empty?

          I18n.locale = 'en'
          portal_notification.set_translations({ en: { body: portal_notification.untranslated_body['un'] } })
          # level.save!
        end
      end
    end
  end
end
