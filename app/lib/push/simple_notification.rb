module Push
  class SimpleNotification < BasePush
    def push(notification, current_user, person_ids)
      @target_people_ids = person_ids

      android_token_notification_push(
        2419200,
        context: "manual_notification",
        title: "#{current_user.username}",
        message_short: notification.body,
        message_long: notification.body,
        message_placeholder: current_user.username
      )

      ios_token_notification_push(
        "#{current_user.username}",
        notification.body,
        nil,
        2419200,
        context: "manual_notification"
      )
    end
  end
end