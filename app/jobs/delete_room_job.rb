class DeleteRoomJob < Struct.new(:room_id)
  include RealTimeHelpers

  def perform
    room = Room.find(room_id)
    c = client
    room.members.each do |m|
      c.delete("#{user_path(m)}/message_counts/#{room_id}")
    end
  end
end
