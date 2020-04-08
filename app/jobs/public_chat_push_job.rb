class PublicChatPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(message_id)
    message = Message.find(message_id)
    product = room.product
    ActsAsTenant.with_tenant(product) do
      private_chat_push(message, message.room, product)
    end
  end
end
