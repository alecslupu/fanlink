module Messaging
  def delete_message(message)
    if message.hidden
      client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
    end
  end

  def post_message(message)
    if message.room.public
      post_public_message(message)
    else
      post_private_message(message)
    end
  end

private

  def client
    @fb ||= Firebase::Client.new(FIREBASE_URL, FIREBASE_KEY)
  end

  def post_private_message(msg)
    client.set("#{room_path(msg.room)}/last_message_id", msg.id)
  end

  def post_public_message(msg)
    client.set("#{room_path(msg.room)}/last_message", msg.as_json)
  end

  def room_path(room)
    "#{room.product.internal_name}/rooms/#{room.id}"
  end
end
