class PrivateChatPushJob < Struct.new(:message_id)
  include Push

  def perform
    message = Message.find(message_id)
    room = message.room
    product = room.product
    ActsAsTenant.with_tenant(product) do
      private_chat_push(message, room, product)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
