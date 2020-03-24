# TODO this is getting messy...divide out into Chat, Post, Relationship subclasses or something
module Messaging
  def clear_message_counter(room, person, version = nil)
    client_update_call(generic_payload_user("message_counts/#{room.id}", person, 0, version))
  end

  def delete_message(message, version = nil)
    return false unless message.hidden

    client_update_call(generic_payload_room("last_deleted_message_id", message, message.id, version))
  end

  def delete_room(room, version = nil)
    room.public? ? delete_public_room(room, version) : delete_private_room(room)
  end

  def delete_room_for_member(room, member, version = nil)
    client_update_call(generic_payload_user("deleted_room_id", member, room.id, version))
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

  def delete_post(post, to_be_notified, version = nil)
    return true if to_be_notified.empty?

    client_update_call( generic_bulk_payload_user("deleted_post_id", to_be_notified, post.id, version) )
  end

  def post_post(post, to_be_notified, version = nil)
    return true if to_be_notified.empty?

    client_update_call(generic_bulk_payload_user("last_post_id", to_be_notified, post.id, version))
  end

  def set_message_counters(room, except_user, version = nil)
    client_update_call(payload_for_set_message_counters(except_user, room, version))
  end

  def update_relationship_count(member, version = nil)
    client_update_call(generic_payload_user("friend_request_count", member, member.friend_request_count, version))
  end

private

  def client_update_call(payload)
    client.update("", payload).response.status == 200
  end

  def generic_payload_user(fragment, member, value, version)
    payload = {}
    payload["#{user_path(member)}/#{fragment}"] = value
    if version.present?
      version.downto(1) {|v|
        payload["#{user_path(member, v)}/#{fragment}"] = value
      }
    end
    payload
  end

  def payload_for_post_public_message(message, msg, version)
    fragment = "last_message"

    payload = {}
    payload["#{room_path(message.room)}/#{fragment}"] = message.as_json
    if version.present?
      version.downto(1) {|v|
        payload["#{room_path(message.room, v)}/#{fragment}"] = msg
      }
    end
    payload
  end

  def generic_payload_room(fragment, msg, value, version)
    payload = {}
    payload["#{room_path(msg.room)}/#{fragment}"] = value
    if version.present?
      version.downto(1) {|v|
        payload["#{room_path(msg.room, v)}/#{fragment}"] = value
      }
    end
    payload
  end

  def generic_bulk_payload_user(fragment, to_be_notified, value, version)
    payload = {}
    to_be_notified.each do |member|
      payload["#{user_path(member)}/#{fragment}"] = value
      if version.present?
        version.downto(1) {|v|
          payload["#{user_path(member, v)}/#{fragment}"] = value
        }
      end
    end
    payload
  end

  def payload_for_set_message_counters(except_user, room, version)
    payload = {}
    room.room_memberships.each do |mem|
      payload[message_counter_path(mem)] = mem.message_count + 1 unless mem.person == except_user
      if version.present?
        version.downto(1) {|v|
          payload[message_counter_path(mem, v)] = mem.message_count + 1 unless mem.person == except_user
        }
      end
    end
    payload
  end

  def add_room_for_member(room, member, version = nil)
    client_update_call(generic_payload_user("new_room_id", member, room.id, version))
  end

  def client
    @fb ||= Firebase::Client.new(Rails.application.secrets.firebase_url, Rails.application.secrets.firebase_key.to_json)
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
      version.downto(1) { |v|
        client.delete(room_path(room, v))
      }
    end
    client.delete(room_path(room))
  end

  def message_counter_path(membership, version = nil)
    [
      user_path(membership.person, version),
      "message_counts",
      membership.room.id
    ].join("/")
  end

  def post_private_message(msg, version = nil)
    client_update_call(generic_payload_room("last_message_id", msg, msg.id, version))
  end

  def post_public_message(message, version = nil)
    msg = {
      id: message.id,
      body: message.parse_content(version.presence || 0),
      # picture_id: message.picture_id,
      create_time: message.create_time,
      picture_url: message.picture_url,
      pinned: message.pinned,
      person: {
        id: message.person.id,
        room_id: message.room_id,
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
    client_update_call( payload_for_post_public_message(message, msg, version))
  end

  def room_path(room, version = nil)
    path = [room.product.internal_name]
    path.push("v#{version}") if version.present?
    path.push(['rooms', room.id])
    path.join("/")
  end

  def user_path(person, version = nil)
    path = [person.product.internal_name]
    path.push("v#{version}") if version.present?
    path.push(['users', person.id])
    path.join("/")
  end
end
