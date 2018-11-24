class MentionPushNotification
  include Push
  def self.message_created(msg_id)
    msg = Message.find(msg_id)
    mentions = parse_content(msg.body, msg.id)
    if mentions
      mentions.each {|mentioned|
        blocks_with = msg.person.blocks_with.map { |b| b.id }
        do_push(mentioned.device_tokens, "Mention", "#{msg.person.username} mentioned you in a message.",
          "message_mentioned", room_id: msg.room_id, message_id: msg.id) unless blocks_with.include?(mentioned.id)
      }
    end
  end
private
  def parse_content(content, msg_id)
    mentions = []
    if content.match?(/\[m\|((?:\w*\s*\w*))\]/i)
      content.scanm(/\[m\|((?:\w*\s*\w*))\]/i).each {|mention|
        person = Person.for_username($1)
        if person
          mentions << person
        end
      }
    elsif conent.match?(/@\w{3,26}/i)
      content.scanm(/@(\w{3,26})/i).each {|mention|
        person = Person.for_username($1)
        if person && !MessageMention.where(messsage_id: msg_id, person_id: person.id).exists?
          mentions << person
        end
      }
    end
    mentions
  end
end
