class AutomatedNotificationPushJob < Struct.new(:notification_id, :person_ids)

  def perform
    Push::ScheduledNotification.new.push(notification_id, person_ids)
  end
end
