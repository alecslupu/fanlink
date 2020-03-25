class DeleteMessageJob < Struct.new(:message_id, :version)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    if message.hidden?
      client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
      if version.present?
        Rails.logger.tagged("Post Message Job") { Rails.logger.debug "Message #{message.id} deleted. Pushing message to version: #{version} path: #{versioned_room_path(message.room, version)}/last_message" } unless Rails.env.production?
        version.downto(1) { |v|
          client.set("#{versioned_room_path(message.room, v)}/last_deleted_message_id", message.id)
        }
      end
    end
  end

  def queue_name
    :default
  end
end
