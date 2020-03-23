class UpdateMessageCounterJob < Struct.new(:room_id, :poster_id, :version)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    if room.private?
      payload = {}
      room.room_memberships.each do |mem|
        payload[message_counter_path(mem)] = mem.message_count unless mem.person_id == poster_id
        if version.present?
          payload[versioned_message_counter_path(mem, version)] = mem.message_count unless mem.person_id == poster_id
        end
      end
      client.update("", payload)
    end
  end

  def queue_name
    :default
  end
end
