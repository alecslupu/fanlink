class ClearMessageCounterJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(room_id, membership_id, version = 0)
    room = Room.find(room_id)
    room_membership = RoomMembership.find(membership_id)

    return unless room.private?
    
    client.set("#{user_path(room_membership.person)}/message_counts/#{room.id}", 0)
    if version.present?
      version.downto(1) do |v|
        client.set("#{versioned_user_path(room_membership.person, v)}/message_counts/#{room.id}", 0)
      end
    end
  end
end
