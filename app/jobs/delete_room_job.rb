# frozen_string_literal: true
class DeleteRoomJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(room_id, version = 0)
    room = Room.find(room_id)

    return unless room.private?

    payload = {}
    room.room_memberships.each do |m|
      payload[message_counter_path(m)] = 0
      payload["#{user_path(m.person)}/deleted_room_id"] = m.room_id
      if version.present?
        version.downto(1) do |v|
          payload[versioned_message_counter_path(m, v)] = 0
          payload["#{versioned_user_path(m.person, v)}/deleted_room_id"] = m.room_id
        end
      end
    end
    client.update("", payload)
    client.delete(room_path(room))
    if version.present?
      version.downto(1) do |v|
        client.delete(versioned_room_path(room, v))
      end
    end
  end
end
