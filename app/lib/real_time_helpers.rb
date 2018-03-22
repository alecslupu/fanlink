module RealTimeHelpers
protected

  def client
    Firebase::Client.new(FIREBASE_URL, FIREBASE_KEY)
  end

  def message_counter_path(membership)
    "#{user_path(membership.person)}/message_counts/#{membership.room_id}"
  end

  def room_path(room)
    "#{room.product.internal_name}/rooms/#{room.id}"
  end

  def user_path(person)
    "#{person.product.internal_name}/users/#{person.id}"
  end
end
