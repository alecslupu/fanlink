# frozen_string_literal: true
class DeleteMessageJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(message_id, version = 0)
    message = Message.find(message_id)
    return unless message.hidden?
    client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
    if version.present?
      version.downto(1) do |v|
        client.set("#{versioned_room_path(message.room, v)}/last_deleted_message_id", message.id)
      end
    end
  end
end
