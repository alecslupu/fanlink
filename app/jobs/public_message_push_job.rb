class PublicMessagePushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(message_id)
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(message.room.product) do
      Push::PublicMessage.new.push(message)
    end
  end
end
