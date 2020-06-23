# frozen_string_literal: true

class MessageMentionPush < BaseMention
  def self.room_message_created(msg_id, product_id)
    msg = Message.find(msg_id)
    if msg.body
      mentions = self.parse_body_content(msg.body, product_id)
      if mentions
        mentions.each do |mentioned|
          blocks_with = msg.person.blocks_with.map { |b| b.id }
          Push::MessageMention.new.push(msg, mentioned) unless blocks_with.include?(mentioned.id)
        end
      end
    end
  end
end
