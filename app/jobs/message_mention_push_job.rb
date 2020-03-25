class MessageMentionPushJob < Struct.new(:message_mention_id)
  include Push

  def perform
    message_mention = MessageMention.find(message_mention_id)
    ActsAsTenant.with_tenant(message_mention.message.room.product) do
      if message_mention.message.room.public?
        message_mention_push(message_mention)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
