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
    do_push(message_mention.person.device_tokens, "Mention", "#{message_mention.message.person.username} mentioned you in a message.",
                              "message_mentioned", room_id: message_mention.message.room_id, message_id: message_mention.message_id)

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
    do_push(post_comment_mention.person.device_tokens, "Mention", "#{post_comment_mention.post_comment.person.username} mentioned you in a comment.",
              "comment_mentioned", post_id: post_comment_mention.post_comment.post_id, comment_id: post_comment_mention.post_comment_id)
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
    resp = push_client.send_to_topic(topic, notification: { body: msg })
    Rails.logger.debug("Got FCM response to topic push: #{resp.inspect}")
    resp[:status_code] == 200
  end
end
