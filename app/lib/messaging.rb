# TODO this is getting messy...divide out into Chat, Post, Relationship subclasses or something
module Messaging
  def clear_message_counter(room, person, version = nil)
    payload = {}
    payload["#{user_path(person)}/message_counts/#{room.id}"] = 0
    if version.present?
      version.downto(1) {|v|
        payload["#{user_path(person, v)}/message_counts/#{room.id}"] = 0
      }
    end
    client.update("", payload).response.status == 200
  end

  def delete_message(message, version = nil)
    if message.hidden
      payload = {}
      payload["#{room_path(message.room)}/last_deleted_message_id"] = message.id
      if version.present?
        version.downto(1) {|v|
          payload["#{room_path(message.room, v)}/last_deleted_message_id"] = message.id
        }
      end
      client.update("", payload).response.status == 200
    else
      false
    end
  end

  def delete_post(post, to_be_notified, version = nil)
    if to_be_notified.empty?
      true
    else
      payload = {}
      to_be_notified.each do |p|
        payload["#{user_path(p)}/deleted_post_id"] = post.id
        if version.present?
          version.downto(1) {|v|
            payload["#{user_path(p, v)}/deleted_post_id"] = post.id
          }
        end
      end
      client.update("", payload).response.status == 200
    end
  end

  def delete_room(room, version = nil)
    if room.public
      delete_public_room(room, version)
    else
      delete_private_room(room)
    end
  end

  def delete_room_for_member(room, member, version = nil)
    payload = {}
    payload["#{user_path(member)}/deleted_room_id"] = room.id
    if version.present?
      version.downto(1) {|v|
        payload["#{user_path(member, v)}/deleted_room_id"] = room.id
      }
    end
    client.update("", payload).response.status == 200
  end

  def new_private_room(room, version = nil)
    room.members.each do |m|
      add_room_for_member(room, m, version)
    end
  end

  def post_message(message, version = nil)
    if message.room.public
      post_public_message(message, version)
    else
      post_private_message(message, version)
    end
  end

  def post_post(post, to_be_notified, version = nil)
    if to_be_notified.empty?
      true
    else
      payload = {}
      to_be_notified.each do |p|
        payload["#{user_path(p)}/last_post_id"] = post.id
        if version.present?
          version.downto(1) {|v|
            payload["#{user_path(p, v)}/last_post_id"] = post.id
          }
        end
      end
      client.update("", payload).response.status == 200
    end
  end

  def set_message_counters(room, except_user, version = nil)
    payload = {}
    room.room_memberships.each do |mem|
      payload[message_counter_path(mem)] = mem.message_count + 1 unless mem.person == except_user
      if version.present?
        version.downto(1) {|v|
          payload[message_counter_path(mem, v)] = mem.message_count + 1 unless mem.person == except_user
        }
      end
    end
    client.update("", payload).response.status == 200
  end

  def update_relationship_count(requested_to, version = nil)
    payload = {}
    payload["#{user_path(requested_to)}/friend_request_count"] = requested_to.friend_request_count
    if version.present?
      version.downto(1) {|v|
        payload["#{user_path(requested_to)}/friend_request_count"] = requested_to.friend_request_count
      }
    end
    client.update("", payload).response.status == 200
  end

private

  def add_room_for_member(room, member, version = nil)
    payload = {}
    payload["#{user_path(member)}/new_room_id"] = room.id
    if version.present?
      version.downto(1) {|v|
        payload["#{user_path(member, v)}/new_room_id"] = room.id
      }
    end
    client.update("", payload).response.status == 200
  end

  def client
    @fb ||= Firebase::Client.new(FIREBASE_URL, FIREBASE_KEY)
  end

  def delete_public_room(room, version = nil)
    delete_room_key(room, version)
  end

  def delete_private_room(room, version = nil)
    room.members.each do |m|
      delete_room_for_member(room, m, version)
    end
    delete_room_key(room, version)
  end

  def delete_room_key(room, version = nil)
    if version.present?
      version.downto(1) {|v|
        client.delete(room_path(room, v))
      }
    end
    client.delete(room_path(room))
  end

  def message_counter_path(membership, version = nil)
    if version.present?
      "#{user_path(membership.person, version)}/message_counts/#{membership.room.id}"
    else
      "#{user_path(membership.person)}/message_counts/#{membership.room.id}"
    end
  end

  def post_private_message(msg, version = nil)
    payload = {}
    payload["#{room_path(msg.room)}/last_message_id"] = msg.id
    if version.present?
      version.downto(1) {|v|
        payload["#{room_path(msg.room, v)}/last_message_id"] = msg.id
      }
    end
    client.update("", payload).response.status == 200
  end

  def post_public_message(message, version = nil)
    msg = {
      id: message.id,
      body: message.parse_content((version.present? ? version : 0)),
      # picture_id: message.picture_id,
      create_time: message.create_time,
      picture_url: message.picture_url,
      pinned: message.pinned,
      person: {
        id: message.person.id,
        username: message.person.username,
        name: message.person.name,
        designation: message.person.designation,
        product_account: message.person.product_account,
        chat_banned: message.person.chat_banned,
        badge_points: message.person.badge_points,
        level: message.person.level,
        picture_url: message.person.picture_url
      }
    }
    payload = {}
    payload["#{room_path(msg.room)}/last_message"] = message.as_json
    if version.present?
      version.downto(1) {|v|
        payload["#{room_path(msg.room)}/last_message"] = msg
      }
    end
    client.update("", payload).response.status == 200
  end

  def room_path(room, version = nil)
    if version.present?
      "#{room.product.internal_name}/v#{version}/rooms/#{room.id}"
    else
      "#{room.product.internal_name}/rooms/#{room.id}"
    end
  end

  def user_path(person, version = nil)
    if version.present?
      "#{person.product.internal_name}/v#{version}/users/#{person.id}"
    else
      "#{person.product.internal_name}/users/#{person.id}"
    end
  end
end
