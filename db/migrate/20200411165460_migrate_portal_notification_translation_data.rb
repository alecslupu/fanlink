class MigratePortalNotificationTranslationData < ActiveRecord::Migration[5.2]
  def up
    if PortalNotification.last.respond_to?(:untranslated_body)
      PortalNotification::Translation.destroy_all
      PortalNotification.where.not(untranslated_body: nil).find_each do |portal_notification|
        Migration::PortalNotificationJob.set(wait_until: 30.minutes.from_now).perform_later(portal_notification)
      end
    end
  end
  def down
  end
end
