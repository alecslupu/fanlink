class DeleteRoomJob < Struct.new(:room_id, :version)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    payload = {}
    c = client
    room.room_memberships.each do |m|
      payload[message_counter_path(m)] = 0
      payload["#{user_path(m.person)}/deleted_room_id"] = m.room_id
      if version.present?
        version.downto(1) { |v|
          payload[versioned_message_counter_path(m, v)] = 0
          payload["#{versioned_user_path(m.person, v)}/deleted_room_id"] = m.room_id
        }
      end
    end
    c.update("", payload)
    c.delete(room_path(room))
    if version.present?
      version.downto(1) { |v|
        c.delete(versioned_room_path(room, v))
      }
    end
  end

  def queue_name
    :default
  end
end
