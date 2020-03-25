module Push
  include ActionView::Helpers::TextHelper

  BATCH_SIZE = 50.freeze

  def friend_request_accepted_push(relationship)
    FriendPush.new.friend_request_accepted_push(relationship)
  end

  def friend_request_received_push(relationship)
    FriendPush.new.friend_request_received_push(relationship)
  end

  def message_mention_push(message, mentioned_person)
    MessagePush.new.message_mention_push(message, mentioned_person)
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

  def post_comment_mention_push(post_comment, mentioned_person)
    PostPush.new.post_comment_mention_push(post_comment, mentioned_person)
  end
  # def simple_notification_push(notification, current_user, receipents)
  #   tokens = []
  #   receipents.each do |person|
  #     tokens += person.notification_device_ids.map { |ndi| ndi.device_identifier }
  #   end
  #   do_push(tokens, current_user.username, notification.body, 'manual_notification', notification_id: notification.id)
  # end

  # def marketing_notification_push(notification)
  #   if notification.send_to_all?
  #     android_notification_body = build_android_notification(
  #                                   notification.ttl_hours * 3600,
  #                                   context: "marketing",
  #                                   title: notification.title,
  #                                   message_short: notification.body,
  #                                   deep_link: notification.deep_link
  #                                 )

  #     ios_notification_body = build_ios_notification(
  #                               notification.title,
  #                               notification.body,
  #                               nil,
  #                               notification.ttl_hours * 3600,
  #                               context: "marketing",
  #                               deep_link: notification.deep_link
  #                             )
  #     notification_topic_push("marketing_en_ios-US", ios_notification_body)
  #     notification_topic_push("marketing_en_android-US", android_notification_body)
  #   else
  #     person_ids = get_person_ids(notification)

  #     NotificationDeviceId.where(person_id: person_ids, device_type: :ios).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
  #       ios_token_notification_push(
  #         notification_device_ids.pluck(:device_identifier),
  #         notification.title,
  #         notification.body,
  #         nil,
  #         notification.ttl_hours * 3600,
  #         context: "marketing",
  #         deep_link: notification.deep_link
  #       )
  #     end

  #     NotificationDeviceId.where(person_id: person_ids, device_type: :android).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
  #       android_token_notification_push(
  #         notification_device_ids.pluck(:device_identifier),
  #         notification.ttl_hours * 3600,
  #         context: "marketing",
  #         title: notification.title,
  #         message_short: notification.body,
  #         deep_link: notification.deep_link
  #       )
  #     end
  #   end
  # end

  # will be later changed to accept language to subscribe to the correct marketing topic
  # def subscribe_device_to_topic(device_identifier, device_type)
  #   response = push_client.topic_subscription(get_topic(device_type), device_identifier)
  #   Rails.logger.error("Got FCM response: #{response.inspect}")
  # end

  # # will be later changed to accept language to unsubscribe to the correct marketing topic
  # def unsubscribe_device_to_topic(device_identifier, device_type)
  #   response = push_client.batch_topic_unsubscription(get_topic(device_type), [device_identifier])
  #   Rails.logger.error("Got FCM response: #{response.inspect}")
  # end

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

  # WHAAA ?
  def get_topic(device_type)
    if device_type == "ios"
      return "marketing_en_ios-US"
    elsif device_type == "android"
      return "marketing_en_android-US"
    end
  end

  # HUH ?
  def make_array(elem)
    elem.is_a?(Array) ? elem : [elem]
  end

  # moved
  def push_client
    @fbcm ||= FCM.new(Rails.application.secrets.firebase_cm_key)
  end
  module_function :push_client

  #moved
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

  # TODO remove
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

  # TODO remove
  def delete_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).destroy_all
  end

  # TODO removed
  def clean_notification_device_ids(resp, phone_os)
    delete_not_registered_device_ids(resp)
    mark_not_registered_device_ids(resp)
    unsubscribe_to_topic(resp, phone_os)
  end

  # TODO remove
  def mark_not_registered_device_ids(device_ids)
    NotificationDeviceId.where(device_identifier: device_ids).update_all(not_registered: true)
  end

  # TODO Remove
  def android_token_notification_push(tokens, ttl, data = {})
    notification_body = build_android_notification(ttl, data)
    push_with_retry(notification_body, tokens, "android")
  end

  # TODO remove
  def ios_token_notification_push(tokens, title, body, click_action, ttl, data = {})
    notification_body = build_ios_notification(title, body, click_action, ttl, data)
    push_with_retry(notification_body, tokens, "ios")
  end

  # TODO Remove
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
  # TODO Remove

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

  # remove this
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

  # def android_chat_notification(android_tokens, message, room, context)
  #   message_short = message.picture_url.present? ? "You’ve got a 📸" : message.body
  #   android_token_notification_push(
  #     android_tokens,
  #     2419200,
  #     context: context,
  #     title: message.person.username,
  #     message_short: message_short,
  #     message_placeholder: message.person.username,
  #     message_long: message.body,
  #     image_url: message.picture_url,
  #     room_id: room.id.to_s,
  #     deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
  #   ) unless android_tokens.empty?
  # end

  # def ios_chat_notification(ios_tokens, message, room, context)
  #   body = message.picture_url.present? ? "You’ve got a 📸" : message.body

  #   ios_token_notification_push(
  #     ios_tokens,
  #     message.person.username,
  #     body,
  #     "ReplyToMessage",
  #     2419200,
  #     context: context,
  #     room_id: room.id.to_s,
  #     image_url: message.picture_url,
  #     deep_link: "#{message.product.internal_name}://rooms/#{room.id}"
  #   ) unless ios_tokens.empty?
  # end

  # TODO remove
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
