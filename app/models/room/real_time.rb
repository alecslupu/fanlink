class Room
  module RealTime
    def clear_message_counter(membership)
      Delayed::Job.enqueue(ClearMessageCounterJob.new(self.id, membership.id))
    end

    def delete_me
      Delayed::Job.enqueue(DeleteRoomJob.new(self.id)) if self.private?
    end

    def post
      Delayed::Job.enqueue(PostMessageJob.new(self.id))
    end

    def increment_message_counters(poster_id)
      room_memberships.each do |mem|
        mem.increment!(:message_count) unless mem.person.id == poster_id
      end
      Delayed::Job.enqueue(UpdateMessageCounterJob.new(self.id, poster_id))
    end

    def new_room
      Delayed::Job.enqueue(AddRoomJob.new(self.id)) if self.private?
    end
  end
end
