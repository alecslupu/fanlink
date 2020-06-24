# frozen_string_literal: true

module Push
  class MessageMention < BasePush
    def push(message, mentioned_person)
      @target_person = mentioned_person

      android_token_notification_push(
        2419200,
        context: 'message_mentioned',
        title: 'Mention',
        message_short: "#{message.person.username} mentioned you",
        message_placeholder: @target_person.username,
        deep_link: "#{message.product.internal_name}://rooms/#{message.room.id}",
        type: 'user'
      )

      ios_token_notification_push(
        'Mention',
        "#{message.person.username} mentioned you",
        nil,
        2419200,
        context: 'message_mentioned',
        deep_link: "#{message.product.internal_name}://rooms/#{message.room.id}"
      )
    end
  end
end
