class AutomatedNotificationPushJob < Struct.new(:notification_id, :person_ids)

  def perform
    Push::AutomatedNotification.push(notification_id, person_ids)
  end
end
