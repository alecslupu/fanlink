module Push
  include ActionView::Helpers::TextHelper

  def friend_request_accepted_push(relationship)
    if relationship.friended?
      do_push(relationship.requested_by.device_tokens,
              "Friend Request Accepted",
              "#{relationship.requested_to.username} accepted your friend request",
              "friend_accepted",
              person_id: relationship.requested_to.id)
    end
  end

  def friend_request_received_push(from, to)
    do_push(to.device_tokens, "New Friend Request", "#{from.username} sent you a friend request", "friend_requested", person_id: from.id)
  end

  def message_mention_push(message_mention)
    blocks_with = message_mention.message.person.blocks_with.map { |b| b.id }
    do_push(message_mention.person.device_tokens, "Mention", "#{message_mention.message.person.username} mentioned you in a message.",
                              "message_mentioned", room_id: message_mention.message.room_id, message_id: message_mention.message_id) unless blocks_with.include?(message_mention.person.id)
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
    do_push(post_comment_mention.person.device_tokens, "Mention", "#{post_comment_mention.post_comment.person.username} mentioned you in a comment.",
              "comment_mentioned", post_id: post_comment_mention.post_comment.post_id, comment_id: post_comment_mention.post_comment_id) unless blocks_with.include?(post_comment_mention.person.id)
  end

  # sends to posts followers
  def post_push(post)
    do_push(NotificationDeviceId.where(person_id: post.person.followers).map { |ndi| ndi.device_identifier },
              "New Post", "#{post.person.username} posted", "new_post", post_id: post.id)
  end

  def private_message_push(message)
    tokens = []
    room = message.room
    android_tokens, ios_tokens = get_room_members_tokens(room.members, message)
    room.members.each do |m|
      blocks_with = message.person.blocks_with.map { |b| b.id }
      next if m == message.person
      next if blocks_with.include?(m.id)
      tokens += m.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, message.person.username, truncate(message.body), "message_received", room_id: message.room.id, message_id: message.id)

    message_short = message.picture_url.present? ? "You’ve got a 📸" : message.body
    android_token_notification_push(
      android_tokens,
      context: "private_chat",
      title: message.person.username,
      message_short: message_short,
      message_placeholder: message.person.username,
      message_long: message.body,
      image_url: message.picture_url,
      room_id: room.id.to_s,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless android_tokens.empty?
  end

  # def public_message_push
  #   tokens = []
  #   room = message.room
  #   get_room_members_tokens(room.members)

  #   message_short = message.picture_url.present? ? "You’ve got a 📸" : message.body
  #   android_tokens(
  #     tokens,
  #     context: "private_chat",
  #     title: message.person.username,
  #     message_short: message_short,
  #     message_placeholder: message.person.username,
  #     message_long: message.body,
  #     image_url: message.picture_url,
  #     room_id: room.id.to_s,
  #     deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
  #   ) unless tokens.empty?
  # end

  def simple_notification_push(notification, current_user, receipents)
    tokens = []
    receipents.each do |person|
      tokens += person.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, current_user.username, notification.body, 'manual_notification', notification_id: notification.id)
  end

  # will be later changed to accept language to subscribe to the correct marketing topic
  def subscribe_to_topic(tokens)
    topic = "marketing_en-US"
    response = push_client.batch_topic_subscription(topic, make_array(tokens))
  end

  # will be later changed to accept language to unsubscribe to the correct marketing topic
  def unsubscribe_to_topic(tokens)
    topic = "marketing_en-US"
    response = push_client.batch_topic_unsubscription(topic, make_array(tokens))
  end


private

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
      push_with_retry(options, tokens)
    end
  end
  module_function :do_push

  def push_with_retry(options, tokens)
    resp = nil
    begin
      retries ||= 0
      Rails.logger.error("Sending push with: tokens: #{tokens.inspect} and options: #{options.inspect}")
      resp = push_client.send(tokens.sort, options)
      Rails.logger.error("Got FCM response: #{resp.inspect}")
      clean_notification_device_ids(resp[:not_registered_ids]) unless resp.nil?
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
      clean_notification_device_ids(resp[:not_registered_ids]) unless resp.nil?
    rescue Errno::EPIPE
      # FLAPI-839
      disconnect
      retry if (retries += 1) < 2
    end
    resp[:status_code] == 200
  end

  def delete_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).destroy_all
  end

  def clean_notification_device_ids(resp)
    delete_not_registered_device_ids(resp)
    mark_not_registered_device_ids(resp)
    unsubscribe_to_topic(resp)
  end

  def mark_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).update_all(not_registered: true)
  end

  def android_token_notification_push(tokens, data = {})
    notification_body = build_android_notification(data)

    push_with_retry(notification_body, tokens)
  end

  # def ios_token_notification_push
  #   notification_body = build_android_notification(type, context, title, message_short, message_placeholder, message_long, image_url, room_id, relationship_id, deep_link)

  #   push_with_retry(notification_body, tokens)
  # end

  def build_android_notification(data)
    options = {}
    data[:type] = "user"
    options[:data] = data

    # this may be used for v1 implementation
    # options[:android] = build_android_options

    return options
  end

  def get_room_members_tokens(members, message)
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
