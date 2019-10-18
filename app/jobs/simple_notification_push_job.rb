class SimpleNotificationPushJob < Struct.new(:notification_id)
  include Push

  def perform
    notification = Notification.find(notification_id)
    ActsAsTenant.with_tenant(notification.person.product) do
      if notification.room.private?
        simple_notification_push(notification)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
