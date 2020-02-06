class MentionPushNotification
  include Push
  def message_created(msg_id, product_id)
    Rails.logger.tagged("Message Created") { Rails.logger.debug "Message #{msg_id} created. Checking for mentions..." } unless Rails.env.production?
    msg = Message.find(msg_id)
    if msg.body
      mentions = self.parse_content(msg.body, msg.id, product_id)
      if mentions
        mentions.each { |mentioned|
          blocks_with = msg.person.blocks_with.map { |b| b.id }
          Push.do_push(mentioned.device_tokens, "Mention", "#{msg.person.username} mentioned you in a message.",
            "message_mentioned", room_id: msg.room_id, message_id: msg.id) unless blocks_with.include?(mentioned.id)
        }
      end
    end
  end
private
  def self.parse_content(content, msg_id, product_id)
    mentions = []
    if content.match?(/\[m\|((?:\w*\s*\w*))\]/i)
      content.scanm(/\[m\|((?:\w*\s*\w*))\]/i).each { |mention|
        person = Person.find_by(username_canonical: Person.canonicalize(mention[1]), product_id: product_id)
        if person
          Rails.logger.tagged("Message Created::Parse Content") { Rails.logger.debug "User found in message, adding them to the notification array." } unless Rails.env.production?
          mentions << person
        end
      }
    elsif content.match?(/@\w{3,26}/i)
      content.scanm(/@(\w{3,26})/i).each { |mention|
        person = Person.find_by(username_canonical: Person.canonicalize(mention[1]), product_id: product_id)
        if person && !MessageMention.where(message_id: msg_id, person_id: person.id).exists?
          mentions << person
        end
      }
    end
    mentions
  end
end
