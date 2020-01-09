module Push
  include ActionView::Helpers::TextHelper

  def friend_request_accepted_push(relationship)
    to = relationship.requested_to
    from = relationship.requested_by
    android_tokens, ios_tokens = get_device_tokens(from)

    if relationship.friended?
      do_push(relationship.requested_by.device_tokens,
              "Friend Request Accepted",
              "#{relationship.requested_to.username} accepted your friend request",
              "friend_accepted",
              person_id: relationship.requested_to.id)

      android_token_notification_push(
        android_tokens,
        context: "friend_accepted",
        title: "Friend request accepted by #{to.username}",
        message_short: "Friend request accepted by #{to.username}",
        message_placeholder: to.username,
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      ) unless android_tokens.empty?

      ios_token_notification_push(
        ios_tokens,
        "Friend request accepted by #{to.username}",
        "Friend request accepted by #{to.username}",
        "AcceptOrIgnore",
        context: "friend_accepted",
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      ) unless ios_tokens.empty?
    end
  end

  def friend_request_received_push(relationship)
    from = relationship.requested_by
    to = relationship.requested_to
    android_tokens, ios_tokens = get_device_tokens(from)

    do_push(to.device_tokens, "New Friend Request", "#{from.username} sent you a friend request", "friend_requested", person_id: from.id)

    android_token_notification_push(
      android_tokens,
      context: "friend_requested",
      title: "Friend request",
      message_short: "New friend request from #{from.username}",
      message_placeholder: from.username,
      image_url: from.picture_url,
      relationship_id: relationship.id,
      deep_link: "#{from.product.internal_name}://users/#{from.id}"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      "Friend request",
      "New friend request from #{from.username}",
      "AcceptOrIgnore",
      context: "friend_requested",
      relationship_id: relationship.id,
      image_url: from.picture_url,
      deep_link: "#{from.product.internal_name}://users/#{from.id}"
    ) unless ios_tokens.empty?
  end

  def message_mention_push(message_mention)
    blocks_with = message_mention.message.person.blocks_with.map { |b| b.id }
    mentioner = message_mention.message.person

    android_tokens, ios_tokens = get_device_tokens(message_mention.person)

    do_push(message_mention.person.device_tokens, "Mention", "#{mentioner.username} mentioned you in a message.",
                              "message_mentioned", room_id: message_mention.message.room_id, message_id: message_mention.message_id) unless blocks_with.include?(message_mention.person.id)

    android_token_notification_push(
      android_tokens,
      context: "message_mentioned",
      title: "Mention",
      message_short: "#{mentioner.username} mentioned you",
      message_placeholder: mentioner.username,
      deep_link: "#{message_mention.message.product.internal_name}://rooms/#{message_mention.message.room.id}"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      "Mention",
      "#{person.username} mentioned you",
      nil,
      context: "message_mentioned",
      deep_link: "#{message_mention.message.product.internal_name}://rooms/#{message_mention.message.room.id}"
    ) unless ios_tokens.empty?
  end

  def portal_notification_push(portal_notification)
    topics = portal_notification.push_topics
    tried = succeeded = 0
    topics.each do |l, c|
      body = (portal_notification.body(l).blank?) ? portal_notification.body : portal_notification.body(l)
      tried += 1
      if do_topic_push(c, body)
        succeeded += 1
      end
    end
    if tried > 0
      if tried == succeeded
        portal_notification.sent!
      else
        (succeeded == 0) ? portal_notification.errored! : portal_notification.partly_errored!
      end
    end
  end

  def post_comment_mention_push(post_comment_mention)
    blocks_with = post_comment_mention.post_comment.person.blocks_with.map { |b| b.id }
    person = post_comment_mention.person
    post_id = post_comment_mention.post_comment.post_id

    do_push(person.device_tokens, "Mention", "#{post_comment_mention.post_comment.person.username} mentioned you in a comment.",
              "comment_mentioned", post_id: post_comment_mention.post_comment.post_id, comment_id: post_comment_mention.post_comment_id) unless blocks_with.include?(person.id)

    android_tokens, ios_tokens = get_device_tokens(person)

    android_token_notification_push(
      android_tokens,
      context: "comment_mentioned",
      title: "Mention",
      message_short: "#{person.username} mentioned you",
      message_placeholder: person.username,
      deep_link: "#{person.product.internal_name}://posts/#{post_id}/comments"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      "Mention",
      "#{person.username} mentioned you",
      nil,
      context: "comment_mentioned",
      deep_link: "#{person.product.internal_name}://posts/#{post_id}/comments"
    ) unless ios_tokens.empty?
  end

  # sends to posts followers
  def post_push(post)
    person = post.person
    do_push(NotificationDeviceId.where(person_id: person.followers).map { |ndi| ndi.device_identifier },
              "New Post", "#{person.username} posted", "new_post", post_id: post.id)

    android_tokens, ios_tokens = get_followers_device_tokens(person)

    android_token_notification_push(
      android_tokens,
      context: "feed_post",
      title: "New post",
      message_short: "New post from #{person.username}",
      message_placeholder: person.username,
      deep_link: "#{person.product.internal_name}://posts/#{post.id}/comments"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      "New Post",
      "New post from #{person.username}",
      nil,
      context: "feed_post",
      deep_link: "#{person.product.internal_name}://posts/#{post.id}/comments"
    ) unless ios_tokens.empty?
  end

  def private_message_push(message)
    tokens = []
    room = message.room
    android_tokens, ios_tokens = get_room_members_device_tokens(room.members, message)
    room.members.each do |m|
      blocks_with = message.person.blocks_with.map { |b| b.id }
      next if m == message.person
      next if blocks_with.include?(m.id)
      tokens += m.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, message.person.username, truncate(message.body), "message_received", room_id: room.id, message_id: message.id)

    android_chat_notification(android_tokens, message, room, "private_chat")
    ios_chat_notification(ios_tokens, message, room, "private_chat")
  end

  def public_message_push(message)
    tokens = []
    room = message.room
    room_subscribers = RoomSubscriber.where(room_id: room.id).where("last_notification_time < ?", DateTime.now - 2.minute).where.not(person_id: message.person_id)
    room_subscribers_ids = room_subscribers.pluck(:person_id)
    android_tokens, ios_tokens = get_room_members_device_tokens(Person.where(id: room_subscribers_ids), message)

    room_subscribers.update_all(last_notification_time: DateTime.now, last_message_id: message.id)

    android_chat_notification(android_tokens, message, room, "public_chat")
    ios_chat_notification(ios_tokens, message, room, "public_chat")
  end

  def simple_notification_push(notification, current_user, receipents)
    tokens = []
    receipents.each do |person|
      tokens += person.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, current_user.username, notification.body, 'manual_notification', notification_id: notification.id)
  end

  def marketing_notification_push(notification, current_user, receipents)
    android_data = build_data(
                    title: notification.title,
                    context: "marketing",
                    message_short: notification.body,
                    message_placeholder: notification.person.username,
                    message_long: notification.body,
                    deep_link: "#{notification.product.internal_name}://users/#{notification.person.id}/profile"
                    )
    android_notification_body = build_android_notification(android_data)

    ios_data = build_data(context: "marketing", deep_link: "#{notification.product.internal_name}://users/#{notification.person.id}/profile")
    ios_notification_body = build_ios_notification(
                              notification.title,
                              notification.body,
                              nil,
                              ios_data
                            )
  end

  # will be later changed to accept language to subscribe to the correct marketing topic
  def subscribe_device_to_topic(notification_device_id)
    response = push_client.topic_subscription(get_topic(notification_device_id), notification_device_id.device_identifier)
    Rails.logger.error("Got FCM response: #{response.inspect}")
  end

  # will be later changed to accept language to unsubscribe to the correct marketing topic
  def unsubscribe_device_to_topic(notification_device_id)
    response = push_client.batch_topic_unsubscription(get_topic(notification_device_id), [notification_device_id.device_identifier])
    Rails.logger.error("Got FCM response: #{response.inspect}")
  end


private

  def get_topic(notification_device_id)
    notification_device_id.device_type == "ios" ? "marketing_en_ios-US" : "marketing_en_android-US"
  end

  def make_array(elem)
    elem.is_a?(Array) ? elem : [elem]
  end

  def push_client
    @fbcm ||= FCM.new(Rails.application.secrets.firebase_cm_key)
  end
  module_function :push_client

  def disconnect
    @fbcm = nil
  end

  def do_push(tokens, title, body, type, data = {})
    unless tokens.empty?
      options = {}
      options[:notification] = {}
      options[:notification][:title] = title
      options[:notification][:body] = body
      options[:notification][:sound] = "default"
      options[:content_available] = true
      options[:data] = data
      options[:data][:notification_type] = type
      options[:data][:priority] = "high"
      push_with_retry(options, tokens, nil)
    end
  end
  module_function :do_push

  def push_with_retry(options, tokens, phone_os)
    resp = nil
    begin
      retries ||= 0
      Rails.logger.error("Sending push with: tokens: #{tokens.inspect} and options: #{options.inspect}")
      resp = push_client.send(tokens.sort, options)
      Rails.logger.error("Got FCM response: #{resp.inspect}")
      clean_notification_device_ids(resp[:not_registered_ids], phone_os) unless resp.nil?
    rescue Errno::EPIPE
      # FLAPI-839
      disconnect
      retry if (retries += 1) < 2
    end
    resp
  end

  def do_topic_push(topic, msg)
    begin
      Rails.logger.debug("Sending topic push with: topic: #{topic} and msg: #{msg}")
      resp = push_client.send_to_topic(topic, notification: { body: msg })
      Rails.logger.debug("Got FCM response to topic push: #{resp.inspect}")
      clean_notification_device_ids(resp[:not_registered_ids], phone_os) unless resp.nil?
    rescue Errno::EPIPE
      # FLAPI-839
      disconnect
      retry if (retries += 1) < 2
    end
    resp[:status_code] == 200
  end

  def notification_topic_push(topic, options)
    begin
      Rails.logger.debug("Sending topic push with: topic: #{topic}")
      resp = push_client.send_to_topic(topic, options)
      Rails.logger.debug("Got FCM response to topic push: #{resp.inspect}")
      # clean_notification_device_ids(resp[:not_registered_ids]) unless resp.nil?
    rescue Errno::EPIPE
      # FLAPI-839
      disconnect
      retry if (retries += 1) < 2
    end
    resp
  end

  def delete_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).destroy_all
  end

  def clean_notification_device_ids(resp, phone_os)
    delete_not_registered_device_ids(resp)
    mark_not_registered_device_ids(resp)
    unsubscribe_to_topic(resp, phone_os)
  end

  def mark_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).update_all(not_registered: true)
  end

  def android_token_notification_push(tokens, data = {})
    notification_body = build_android_notification(data)
    push_with_retry(notification_body, tokens, "android")
  end

  def ios_token_notification_push(tokens, title, body, click_action, data = {})
    notification_body = build_ios_notification(title, body, click_action, data)
    push_with_retry(notification_body, tokens, "ios")
  end

  def build_android_notification(data)
    options = {}
    data[:type] = "user"
    options[:data] = data

    # this may be used for v1 implementation
    # options[:android] = build_android_options

    return options
  end

  def build_ios_notification(title, body, click_action, data)
    options = {}
    options[:notification] = {}

    options[:notification][:title] = title
    options[:notification][:body] = body
    options[:notification][:click_action] = click_action
    options[:notification][:sound] = "default"
    options[:notification][:mutable_content] = "true"

    options[:data] = data
    options[:data][:priority] = "high"
    options[:data][:time_to_live] = "2419200"

    return options
  end

  def get_room_members_device_tokens(members, message)
    android_tokens = []
    ios_tokens = []
    members.each do |m|
      blocks_with = message.person.blocks_with.map { |b| b.id }
      next if m == message.person
      next if blocks_with.include?(m.id)
      android_tokens += m.notification_device_ids.where(device_type: :android).map { |ndi| ndi.device_identifier }
      ios_tokens += m.notification_device_ids.where(device_type: :ios).map { |ndi| ndi.device_identifier }
    end

    return android_tokens, ios_tokens
  end

  def get_device_tokens(person)
    android_tokens = person.notification_device_ids.where(device_type: :android).map { |ndi| ndi.device_identifier }
    ios_tokens = person.notification_device_ids.where(device_type: :ios).map { |ndi| ndi.device_identifier }

    return android_tokens, ios_tokens
  end

  def get_followers_device_tokens(person)
    android_tokens = NotificationDeviceId.where(person_id: person.followers, device_type: :android).pluck(:device_identifier)
    ios_tokens = NotificationDeviceId.where(person_id: person.followers, device_type: :ios).pluck(:device_identifier)

    return android_tokens, ios_tokens
  end

  def android_chat_notification(android_tokens, message, room, context)
    message_short = message.picture_url.present? ? "You’ve got a 📸" : message.body
    android_token_notification_push(
      android_tokens,
      context: context,
      title: message.person.username,
      message_short: message_short,
      message_placeholder: message.person.username,
      message_long: message.body,
      image_url: message.picture_url,
      room_id: room.id.to_s,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless android_tokens.empty?
  end

  def ios_chat_notification(ios_tokens, message, room, context)
    body = message.picture_url.present? ? "You’ve got a 📸" : message.body

    ios_token_notification_push(
      ios_tokens,
      message.person.username,
      body,
      "ReplyToMessage",
      context: context,
      room_id: room.id.to_s,
      image_url: message.picture_url,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless ios_tokens.empty?
  end

  def build_data(data = {})
    data
  end

  def unsubscribe_to_topic(tokens, phone_os)
    case phone_os
    when nil
      ["marketing_en_ios-US", "marketing_en_android-US"].each do |topic|
        response = push_client.batch_topic_unsubscription(topic, make_array(tokens))
      end
    when "android"
      response = push_client.batch_topic_unsubscription("marketing_en_android-US", make_array(tokens))
    when "ios"
      response = push_client.batch_topic_unsubscription("marketing_en_ios-US", make_array(tokens))
    end
  end

  # def build_android_options
  #   android = {}
  #   android[:priority] = "high"
  #   android[:ttl] = "86400s"
  #   android[:collapse_key] = "collapse_key"
  #   android[:fcm_options] = {}
  #   android[:fcm_options][:analytics_label] = "string"

  #   return android
  # end

end
