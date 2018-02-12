module Push

  def friend_request_received_push(from, to)
    do_push(to.device_tokens, "New Friend Request", "#{from.username} sent you a friend request", "friend_requested", person_id: from.id)
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
      options[:content_available] = true
      options[:data] = data
      options[:data][:notificaiton_type] = type
      options[:data][:priority] = 'high'
      Rails.logger.debug("Sending push with: tokens: #{tokens.inspect} and options: #{options.inspect}")
      push_client.send(tokens, options)
    end
  end
end
