class DeleteRoomJob < Struct.new(:room_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    payload = {}
    c = client
    room.members.each do |m|
      payload[message_counter_path(m)] = 0
      payload["#{user_path(m)}/deleted_room_id"] = m.room_id
    end
    c.update("", payload)
    c.delete(room_path(room))
  end
end
