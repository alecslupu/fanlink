class PortalNotificationPushJob < Struct.new(:portal_notification_id)
  include Push

  def perform
    portal_notification = PortalNotification.find(portal_notification_id)
    ActsAsTenant.with_tenant(portal_notification.product) do
      portal_notification_push(portal_notification)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
