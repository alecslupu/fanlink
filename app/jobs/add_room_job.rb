# frozen_string_literal: true
class AddRoomJob < ApplicationJob
  include RealTimeHelpers

  queue_as :chat

  def perform(room_id, version = 0)
    room = Room.find(room_id)
    return unless room.private?
    payload = {}
    room.members.each do |m|
      payload["#{user_path(m)}/new_room_id"] = room_id
      if version.present?
        version.downto(1) do |v|
          payload["#{versioned_user_path(m, v)}/new_room_id"] = room_id
        end
      end
    end
    client.update("", payload)
  end
end
