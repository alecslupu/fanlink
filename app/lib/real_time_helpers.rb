module RealTimeHelpers

protected

  def client
    Firebase::Client.new(FIREBASE_URL, FIREBASE_KEY)
  end

  def room_path(room)
    "#{room.product.internal_name}/rooms/#{room.id}"
  end

end