class PostMessageJob < Struct.new(:message_id)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(msg.room.product) do
      if message.room.public?
        client.set("#{room_path(message.room)}/last_message", message.as_json)
      else
        client.set("#{room_path(message.room)}/last_message_id", message.id)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
