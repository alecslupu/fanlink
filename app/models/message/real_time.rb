class Message
  module RealTime
    def delete_real_time(version = 0)
      Delayed::Job.enqueue(DeleteMessageJob.new(self.id, version))
    end

    def post(version = 0)
      Delayed::Job.enqueue(PostMessageJob.new(self.id, version))
      push_mentions
    end

    def private_message_push
      Delayed::Job.enqueue(PrivateMessagePushJob.new(self.id))
    end


  private
    def push_mentions
      message_mentions.each do |m|
        Delayed::Job.enqueue(MessageMentionPushJob.new(m.id))
      end
    end
  end
end
