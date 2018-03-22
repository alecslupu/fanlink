class UpdateMessageCounterJob < Struct.new(:room_id, :poster_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    if room.private?
      payload = {}
      room.room_memberships.each do |mem|
        payload[message_counter_path(mem)] = mem.message_count unless mem.person_id == poster_id
      end
      client.update("", payload)
    end
  end
end
