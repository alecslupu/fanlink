class PrivateMessagePushJob < Struct.new(:message_id)
  include Push

  def perform
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(message.room.product) do
      Push::PrivateMessage.new.push(message)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
