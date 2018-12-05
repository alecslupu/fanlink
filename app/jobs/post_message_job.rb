class PostMessageJob < Struct.new(:message_id)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(message.room.product) do
        client.set("#{room_path(message.room)}/last_message_id", message.id)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
