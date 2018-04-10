class PostMessageJob < Struct.new(:message_id)
  include RealTimeHelpers

  def perform
    client.set("#{room_path(message.room)}/last_message_id", message_id)
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
