class IncrementMessageCounterJob < Struct.new(:room_id, :poster_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    if room.private?
      payload = {}
      room.room_memberships.each do |mem|
        payload[message_counter_path(mem, room.id)] = mem.message_count unless mem.person_id == poster_id
      end
      client.update("", payload)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
