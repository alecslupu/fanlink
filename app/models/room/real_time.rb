class Room
  module RealTime
    def clear_message_counter(membership)
      Delayed::Job.enqueue(ClearMessageCounterJob.new(self.id, membership.id))
    end

    def post
      Delayed::Job.enqueue(PostMessageJob.new(self.id))
    end

    def increment_message_counters(poster_id)
      room_memberships.each do |mem|
        mem.increment!(:message_count) unless mem.person.id == poster_id
      end
      Delayed::Job.enqueue(ClearMessageCounterJob.new(self.id, poster_id))
    end
  end
end
