class ClearMessageCounterJob < Struct.new(:room_id, :membership_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    room_membership = RoomMembership.find(membership_id)
    if room.private?
      client.set("#{user_path(room_membership.person)}/message_counts/#{room.id}", 0)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

end