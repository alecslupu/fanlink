module Push
  class ScheduledNotification < BasePush
    def push(notification_id, person_ids)
      notification = AutomatedNotification.find(notification_id)
      @target_people_ids = person_ids

      android_token_notification_push(
        notification.ttl_hours * 3600,
        context: "marketing",
        title: notification.title,
        message_short: notification.body,
      )

      ios_token_notification_push(
        notification.title,
        notification.body,
        nil,
        notification.ttl_hours * 3600,
        context: "marketing"
      )
    end
  end
end
