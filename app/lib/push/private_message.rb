# frozen_string_literal: true
module Push
  class PrivateMessage < BasePush

    def push(message)
      room = message.room
      person = message.person
      message_body = message.picture_url.present? ? "You’ve got a 📸" : message.body
      @target_people_ids = get_unblocked_members(room.members, person)

      android_token_notification_push(
        2419200,
        context: "private_chat",
        title: person.username,
        message_short: message_body,
        message_placeholder: person.username,
        message_long: message.body,
        image_url: message.picture_url,
        room_id: room.id.to_s,
        deep_link: "#{message.product.internal_name}://rooms/#{room.id}",
        type: "user"
      )


      ios_token_notification_push(
        person.username,
        message_body,
        "ReplyToMessage",
        2419200,
        context: "private_chat",
        room_id: room.id.to_s,
        image_url: message.picture_url,
        deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
      )
    end

    private

      def get_unblocked_members(members, person)
        member_ids = []

        members.each do |member|
          blocks_with = person.blocks_with.map { |b| b.id }
          next if member == person
          next if blocks_with.include?(member.id)

          member_ids << member.id
        end

        return member_ids
      end
  end
end
