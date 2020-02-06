module Push
  class MessagePush < BasePush

    def message_mention_push(message, mentioned_person)
      target_person = mentioned_person

      android_token_notification_push(
        2419200,
        context: "message_mentioned",
        title: "Mention",
        message_short: "#{message.person.username} mentioned you",
        message_placeholder: mentioned_person.username,
        deep_link: "#{message.product.internal_name}://rooms/#{message.room.id}"
      )

      ios_token_notification_push(
        "Mention",
        "#{message.person.username} mentioned you",
        nil,
        2419200,
        context: "message_mentioned",
        deep_link: "#{message.product.internal_name}://rooms/#{message.room.id}"
      )
    end
  end
end
