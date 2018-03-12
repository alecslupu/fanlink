class DeleteMessageJob < Struct.new(:message_id)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    if message.hidden?
      client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
    end
  end
end
