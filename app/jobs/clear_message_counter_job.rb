class ClearMessageCounterJob < Struct.new(:room_id, :membership_id, :version)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    room_membership = RoomMembership.find(membership_id)
    if room.private?
      client.set("#{user_path(room_membership.person)}/message_counts/#{room.id}", 0)
      if version.present?
        client.set("#{versioned_user_path(room_membership.person, version)}/message_counts/#{room.id}", 0)
      end
    end
  end
end
