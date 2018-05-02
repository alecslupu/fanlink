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

  def portal_notification_push(portal_notification)
    topics = portal_notification.get_push_topics
    topics.each do |l, c|
      body = (portal_notification.body(l).blank?) ? portal_notification.body : portal_notification.body(l)
      do_topic_push(c, body)
    end
  end

  def private_message_push(message)
    tokens = []
    message.room.members.each do |m|
      next if m == message.person
      tokens += m.notification_device_ids.map { |ndi| ndi.device_identifier }
    end
    do_push(tokens, message.person.username, truncate(message.body), "message_received", room_id: message.room.id, message_id: message.id)
  end

private

  def push_client
    @fbcm ||= FCM.new(FIREBASE_CM_KEY)
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
      Rails.logger.debug("Sending push with: tokens: #{tokens.inspect} and options: #{options.inspect}")
      resp = push_client.send(tokens, options)
      Rails.logger.debug("Got FCM response: #{resp.inspect}")
    end
  end

  def do_topic_push(topic, msg)
    Rails.logger.debug("Sending topic push with: topic: #{topic} and msg: #{msg}")
    resp = push_client.send_to_topic(topic, data: { message: msg })
    Rails.logger.debug("Got FCM response to topic push: #{resp.inspect}")
  end
end
