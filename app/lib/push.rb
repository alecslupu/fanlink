module Push
  include ActionView::Helpers::TextHelper

  BATCH_SIZE = 50.freeze

  def friend_request_accepted_push(relationship)
    to = relationship.requested_to
    from = relationship.requested_by
    android_tokens, ios_tokens = get_device_tokens(from)

    if relationship.friended?
      # do_push(relationship.requested_by.device_tokens,
      #         "Friend Request Accepted",
      #         "#{relationship.requested_to.username} accepted your friend request",
      #         "friend_accepted",
      #         person_id: relationship.requested_to.id)
    #   do_push(relationship.requested_by.device_tokens,
    #           "Friend Request Accepted",
    #           "#{relationship.requested_to.username} accepted your friend request",
    #           "friend_accepted",
    #           person_id: relationship.requested_to.id)

      android_token_notification_push(
        android_tokens,
        2419200,
        context: "friend_accepted",
        title: "Friend request accepted by #{to.username}",
        message_short: "Friend request accepted by #{to.username}",
        message_placeholder: to.username,
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      ) unless android_tokens.empty?

      ios_token_notification_push(
        ios_tokens,
        "Friend request accepted",
        "Friend request accepted by #{to.username}",
        nil,
        2419200,
        context: "friend_accepted",
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      ) unless ios_tokens.empty?
    end
  end

  def friend_request_received_push(relationship)
    from = relationship.requested_by
    to = relationship.requested_to
    android_tokens, ios_tokens = get_device_tokens(to)
    profile_picture_url = from.picture_url.present? ? from.picture_url : from.facebook_picture_url

    # do_push(to.device_tokens, "New Friend Request", "#{from.username} sent you a friend request", "friend_requested", person_id: from.id)

    android_token_notification_push(
      android_tokens,
      2419200,
      context: "friend_requested",
      title: "Friend request",
      message_short: "New friend request from #{from.username}",
      message_placeholder: from.username,
      image_url: profile_picture_url,
      relationship_id: relationship.id,
      deep_link: "#{from.product.internal_name}://users/#{from.id}"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      "Friend request",
      "New friend request from #{from.username}",
      "AcceptOrIgnore",
      2419200,
      context: "friend_requested",
      relationship_id: relationship.id,
      image_url: profile_picture_url,
      deep_link: "#{from.product.internal_name}://users/#{from.id}"
    ) unless ios_tokens.empty?
  end

  def message_mention_push(message_mention)
    mentionner = message_mention.message.person
    blocks_with = mentionner.blocks_with.map { |b| b.id }

    android_tokens, ios_tokens = get_device_tokens(message_mention.person)

    # do_push(message_mention.person.device_tokens, "Mention", "#{mentionner.username} mentioned you in a message.",
                              # "message_mentioned", room_id: message_mention.message.room_id, message_id: message_mention.message_id) unless blocks_with.include?(message_mention.person.id)
    #                           "message_mentioned", room_id: message_mention.message.room_id, message_id: message_mention.message_id) unless blocks_with.include?(message_mention.person.id)

    android_token_notification_push(
      android_tokens,
      2419200,
      context: "message_mentioned",
      title: "Mention",
      message_short: "#{mentionner.username} mentioned you",
      message_placeholder: mentionner.username,
      deep_link: "#{message_mention.message.product.internal_name}://rooms/#{message_mention.message.room.id}"
    ) unless android_tokens.empty? || blocks_with.include?(message_mention.person.id)

    ios_token_notification_push(
      ios_tokens,
      "Mention",
      "#{mentionner.username} mentioned you",
      nil,
      2419200,
      context: "message_mentioned",
      deep_link: "#{message_mention.message.product.internal_name}://rooms/#{message_mention.message.room.id}"
    ) unless ios_tokens.empty? || blocks_with.include?(message_mention.person.id)
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
    mentioned_person = post_comment_mention.person
    mentionner = post_comment_mention.post_comment.person
    blocks_with = mentionner.blocks_with.map { |b| b.id }
    post_id = post_comment_mention.post_comment.post_id

    # do_push(mentioned_person.device_tokens, "Mention", "#{mentionner.username} mentioned you in a comment.",
    #           "comment_mentioned", post_id: post_id, comment_id: post_comment_mention.post_comment_id) unless blocks_with.include?(mentioned_person.id)

    android_tokens, ios_tokens = get_device_tokens(mentioned_person)

    android_token_notification_push(
      android_tokens,
      2419200,
      context: "comment_mentioned",
      title: "Mention",
      message_short: "#{mentionner.username} mentioned you",
      message_placeholder: mentionner.username,
      deep_link: "#{mentionner.product.internal_name}://posts/#{post_id}/comments"
    ) unless android_tokens.empty? || blocks_with.include?(mentioned_person.id)

    ios_token_notification_push(
      ios_tokens,
      "Mention",
      "#{mentionner.username} mentioned you",
      nil,
      2419200,
      context: "comment_mentioned",
      deep_link: "#{mentionner.product.internal_name}://posts/#{post_id}/comments"
    ) unless ios_tokens.empty? || blocks_with.include?(mentioned_person.id)
  end

  # sends to posts followers
  def post_push(post)
    person = post.person
    # do_push(NotificationDeviceId.where(person_id: person.followers).map { |ndi| ndi.device_identifier },
    #           "New Post", "#{person.username} posted", "new_post", post_id: post.id)

    android_tokens, ios_tokens = get_followers_device_tokens(person)

    android_token_notification_push(
      android_tokens,
      2419200,
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
      2419200,
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
    # do_push(tokens, message.person.username, truncate(message.body), "message_received", room_id: room.id, message_id: message.id)

    android_chat_notification(android_tokens, message, room, "private_chat")
    ios_chat_notification(ios_tokens, message, room, "private_chat")
  end

  def public_message_push(message)
    tokens = []
    room = message.room
    room_subscribers = RoomSubscriber.where(room_id: room.id).where("last_notification_time < ?", DateTime.current - 2.minute).where.not(person_id: message.person_id)
    android_tokens, ios_tokens = get_room_members_device_tokens(Person.where(id: room_subscribers.pluck(:person_id)), message)
    room_subscribers.update_all(last_notification_time: DateTime.current, last_message_id: message.id)

    android_token_notification_push(
      android_tokens,
      2419200,
      context: "public_chat",
      title: message.product.name,
      message_short: "A new user wrote in the #{room.name}",
      message_placeholder: message.person.username,
      message_long: "A new user wrote in the #{room.name}",
      image_url: message.picture_url,
      room_id: room.id.to_s,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless android_tokens.empty?

    ios_token_notification_push(
      ios_tokens,
      message.product.name,
      "A new user wrote in the #{room.name}",
      "ReplyToMessage",
      2419200,
      context: "public_chat",
      room_id: room.id.to_s,
      image_url: message.picture_url,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless ios_tokens.empty?
  end

  def simple_notification_push(notification, current_user, receipents)
    tokens = []
    receipents.each do |person|
      tokens += person.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, current_user.username, notification.body, 'manual_notification', notification_id: notification.id)
  end

  def marketing_notification_push(notification)
    if notification.send_to_all?
      android_notification_body = build_android_notification(
                                    notification.ttl_hours * 3600,
                                    context: "marketing",
                                    title: notification.title,
                                    message_short: notification.body,
                                    deep_link: notification.deep_link
                                  )

      ios_notification_body = build_ios_notification(
                                notification.title,
                                notification.body,
                                nil,
                                notification.ttl_hours * 3600,
                                context: "marketing",
                                deep_link: notification.deep_link
                              )
      notification_topic_push("marketing_en_ios-US", ios_notification_body)
      notification_topic_push("marketing_en_android-US", android_notification_body)
    else
      person_ids = get_person_ids(notification)

      NotificationDeviceId.where(person_id: person_ids, device_type: :ios).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
        ios_token_notification_push(
          notification_device_ids.pluck(:device_identifier),
          notification.title,
          notification.body,
          nil,
          notification.ttl_hours * 3600,
          context: "marketing",
          deep_link: notification.deep_link
        )
      end

      NotificationDeviceId.where(person_id: person_ids, device_type: :android).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
        android_token_notification_push(
          notification_device_ids.pluck(:device_identifier),
          notification.ttl_hours * 3600,
          context: "marketing",
          title: notification.title,
          message_short: notification.body,
          deep_link: notification.deep_link
        )
      end
    end
  end

  # will be later changed to accept language to subscribe to the correct marketing topic
  def subscribe_device_to_topic(device_identifier, device_type)
    response = push_client.topic_subscription(get_topic(device_type), device_identifier)
    Rails.logger.error("Got FCM response: #{response.inspect}")
  end

  # will be later changed to accept language to unsubscribe to the correct marketing topic
  def unsubscribe_device_to_topic(device_identifier, device_type)
    response = push_client.batch_topic_unsubscription(get_topic(device_type), [device_identifier])
    Rails.logger.error("Got FCM response: #{response.inspect}")
  end

  def automated_notification_android_push(device_identifiers, title, body, ttl_hours)
    android_token_notification_push(
      device_identifiers,
      ttl_hours * 3600,
      context: "marketing",
      title: title,
      message_short: body,
    )
  end

  def automated_notification_ios_push(device_identifiers, title, body, ttl_hours)
    ios_token_notification_push(
      device_identifiers,
      title,
      body,
      nil,
      ttl_hours * 3600,
      context: "marketing",
    )
  end


private

  def get_topic(device_type)
    if device_type == "ios"
      return "marketing_en_ios-US"
    elsif device_type == "android"
      return "marketing_en_android-US"
    end
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

  def android_token_notification_push(tokens, ttl, data = {})
    notification_body = build_android_notification(ttl, data)
    push_with_retry(notification_body, tokens, "android")
  end

  def ios_token_notification_push(tokens, title, body, click_action, ttl, data = {})
    notification_body = build_ios_notification(title, body, click_action, ttl, data)
    push_with_retry(notification_body, tokens, "ios")
  end

  def build_android_notification(ttl, data = {})
    options = {}
    data[:type] = "user"
    options[:data] = data
    options[:priority] = "high"
    options[:content_available] = true
    options[:mutable_content] = true
    options[:time_to_live] = ttl

    # this may be used for v1 implementation
    # options[:android] = build_android_options

    return options
  end

  def build_ios_notification(title, body, click_action, ttl, data = {})
    options = {}
    options[:notification] = {}

    options[:notification][:title] = title
    options[:notification][:body] = body
    options[:notification][:click_action] = click_action
    options[:notification][:sound] = "default"
    options[:notification][:mutable_content] = "true"

    options[:data] = data
    options[:data][:priority] = "high"
    options[:data][:time_to_live] = ttl

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
      2419200,
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
      2419200,
      context: context,
      room_id: room.id.to_s,
      image_url: message.picture_url,
      deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
    ) unless ios_tokens.empty?
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

  def get_person_ids(notification)
    case notification.person_filter
    when "has_certificate_enrolled"
      person_ids = Person.has_enrolled_certificate.select(:id)
    when "has_no_certificate_enrolled"
      person_ids = Person.has_no_enrolled_certificate.select(:id)
    when "has_certificate_generated"
      person_ids = Person.has_certificate_generated.select(:id)
    when "has_paid_certificate"
      person_ids = Person.has_paid_certificate.select(:id)
    when "has_no_paid_certificate"
      person_ids = Person.has_no_paid_certificate.select(:id)
    when "has_friends"
      person_ids = Person.with_friendships.select(:id)
    when "has_no_friends"
      person_ids = Person.without_friendships.select(:id)
    when "has_followings"
      person_ids = Person.has_followings.select(:id)
    when "has_no_followings"
      person_ids = Person.has_no_followings.select(:id)
    when "has_interests"
      person_ids = Person.has_interests.select(:id)
    when "has_no_interests"
      person_ids = Person.has_no_interests.select(:id)
    when "has_created_posts"
      person_ids = Person.has_posts.select(:id)
    when "has_no_created_posts"
      person_ids = Person.has_no_posts.select(:id)
    when "has_facebook_id"
      person_ids = Person.has_facebook_id.select(:id)
    when "account_created_past_24h"
      person_ids = Person.has_created_acc_past_24h.select(:id)
    when "accoount_created_past_7_days"
      person_ids = Person.has_created_acc_past_7days.select(:id)
    end

    return person_ids
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
