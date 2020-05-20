# frozen_string_literal: true
class UpdateMessageCounterJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(room_id, poster_id, version)
    room = Room.find(room_id)
    return unless room.private?
    payload = {}
    room.room_memberships.each do |mem|
      payload[message_counter_path(mem)] = mem.message_count unless mem.person_id == poster_id
      if version.present?
        # version.downto(1) do |v|
        #   payload[versioned_message_counter_path(mem, v)] = mem.message_count unless mem.person_id == poster_id
        # end
        payload[versioned_message_counter_path(mem, version)] = mem.message_count unless mem.person_id == poster_id
      end
    end
    client.update("", payload)
  end
end
