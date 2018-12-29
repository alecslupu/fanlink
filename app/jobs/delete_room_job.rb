class DeleteRoomJob < Struct.new(:room_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    payload = {}
    c = client
    room.room_memberships.each do |m|
      payload[message_counter_path(m)] = 0
      payload["#{user_path(m.person, version)}/deleted_room_id"] = m.room_id
      if version.present?
        payload[versioned_message_counter_path(m, version)] = 0
        payload["#{versioned_user_path(m.person, version)}/deleted_room_id"] = m.room_id
      end
    end
    c.update("", payload)
    c.delete(room_path(room))
    if version.present?
      c.delete(versioned_room_path(room, version))
    end
  end
end
