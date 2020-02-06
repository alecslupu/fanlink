module Push
  class PublicMessage < BasePush

    def push(message)
      room = message.room
      room_subscribers = RoomSubscriber.where(room_id: room.id).where("last_notification_time < ?", DateTime.current - 2.minute).where.not(person_id: message.person_id)
      @target_people_ids = room_subscribers.pluck(:person_id)
      room_subscribers.update_all(last_notification_time: DateTime.current, last_message_id: message.id)

      android_token_notification_push(
        2419200,
        context: "public_chat",
        title: message.product.name,
        message_short: "A new user wrote in the #{room.name} Chat Room",
        message_placeholder: message.person.username,
        message_long: "A new user wrote in the #{room.name} Chat Room",
        image_url: message.picture_url,
        room_id: room.id.to_s,
        deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
      )

      ios_token_notification_push(
        message.product.name,
        "A new user wrote in the #{room.name} Chat Room",
        "ReplyToMessage",
        2419200,
        context: "public_chat",
        room_id: room.id.to_s,
        image_url: message.picture_url,
        deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
      )
    end
  end
end
