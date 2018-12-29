class DeleteMessageJob < Struct.new(:message_id, :version)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    if message.hidden?
      client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
      if version.present?
        client.set("#{versioned_room_path(message.room, version)}/last_deleted_message_id", message.id)
      end
    end
  end
end
