class ClearMessageCounterJob < Struct.new(:room_id, :membership_id, :version)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    room_membership = RoomMembership.find(membership_id)
    if room.private?
      client.set("#{user_path(room_membership.person)}/message_counts/#{room.id}", 0)
      if version.present?
        version.downto(1) { |v|
          client.set("#{versioned_user_path(room_membership.person, v)}/message_counts/#{room.id}", 0)
        }

      end
    end
  end

  def queue_name
    :default
  end
end
