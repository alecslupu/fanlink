class AutomatedNotificationIosPushJob < Struct.new(:device_ids, :title, :body, :ttl_hours)
  include Push

  def perform
    automated_notification_ios_push(NotificationDeviceId.where(id: device_ids), title, body, ttl_hours)
  end
end
