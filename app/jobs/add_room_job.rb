class AddRoomJob < Struct.new(:room_id, :version)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    if room.private?
      payload = {}
      room.members.each do |m|
        payload["#{user_path(m)}/new_room_id"] = room_id
        if version.present?
          payload["#{versioned_user_path(m, version)}/new_room_id"] = room_id
        end
      end
      client.update("", payload)
    end
  end
end
