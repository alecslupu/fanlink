module Messaging
  def clear_message_counter(room, person)
    client.set("#{user_path(person)}/message_counts/#{room.id}", 0)
  end

  def delete_message(message)
    if message.hidden
      client.set("#{room_path(message.room)}/last_deleted_message_id", message.id)
    end
  end

  def delete_post(post)
    client.set("#{user_path(post.person)}/deleted_post_id", post.id).response.status == 200
  end

  def delete_room(room)
    if room.public
      delete_public_room(room)
    else
      delete_private_room(room)
    end
  end

  def delete_room_for_member(room, member)
    client.set("#{user_path(member)}/deleted_room_id", room.id)
  end

  def new_private_room(room)
    room.members.each do |m|
      add_room_for_member(room, m)
    end
  end

  def post_message(message)
    if message.room.public
      post_public_message(message)
    else
      post_private_message(message)
    end
  end

  def post_post(post)
    client.set("#{user_path(post.person)}/last_post_id", post.id).response.status == 200
  end

  def post_relationship(relationship)
    relationship.requested? &&
      client.set("#{user_path(relationship.requested_to)}/new_relationship_id", relationship.id).response.status == 200
  end

  def set_message_counters(room, except_user)
    payload = {}
    room.room_memberships.each do |mem|
      payload[message_counter_path(mem)] = mem.message_count + 1 unless mem.person == except_user
    end
    client.update("", payload).response.status == 200
  end

  def update_relationship(relationship, person)
    person.relationships.include?(relationship) &&
        (client.set("#{user_path(person)}/updated_relationship_id", relationship.id).response.status == 200)
  end

private

  def add_room_for_member(room, member)
    client.set("#{user_path(member)}/new_room_id", room.id)
  end

  def client
    @fb ||= Firebase::Client.new(FIREBASE_URL, FIREBASE_KEY)
  end

  def delete_public_room(room)
    delete_room_key(room)
  end

  def delete_private_room(room)
    room.members.each do |m|
      delete_room_for_member(room, m)
    end
    delete_room_key(room)
  end

  def delete_room_key(room)
    client.delete(room_path(room))
  end

  def message_counter_path(membership)
    "#{user_path(membership.person)}/message_counts/#{membership.room.id}"
  end

  def post_private_message(msg)
    client.set("#{room_path(msg.room)}/last_message_id", msg.id).response.status == 200
  end

  def post_public_message(msg)
    client.set("#{room_path(msg.room)}/last_message", msg.as_json).response.status == 200
  end

  def room_path(room)
    "#{room.product.internal_name}/rooms/#{room.id}"
  end

  def user_path(person)
    "#{person.product.internal_name}/users/#{person.id}"
  end
end
