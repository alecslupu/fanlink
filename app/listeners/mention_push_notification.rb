class MentionPushNotification < BaseMention
  include Push
  def message_created(msg_id, product_id)
    Rails.logger.tagged("Message Created") { Rails.logger.debug "Message #{msg_id} created. Checking for mentions..." } unless Rails.env.production?
    msg = Message.find(msg_id)
    if msg.body
      mentions = self.parse_content(msg.body, product_id)
      if mentions
        mentions.each do |mentioned|
          blocks_with = msg.person.blocks_with.map { |b| b.id }
          Push::MessageMention.new.push(msg, mentioned) unless blocks_with.include?(mentioned.id)
        end
      end
    end
  end
end
