class Room
  module RealTime
    def clear_message_counter(membership)
      Delayed::Job.enqueue(ClearMessageCounterJob.new(self.id, membership.id))
    end

    def delete_me(version = 0)
      Delayed::Job.enqueue(DeleteRoomJob.new(self.id, version)) if self.private?
    end

    def post(version = 0)
      Delayed::Job.enqueue(PostMessageJob.new(self.id, version))
    end

    def increment_message_counters(poster_id, version = 0)
      room_memberships.each do |mem|
        mem.increment!(:message_count) unless mem.person.id == poster_id
      end
      Delayed::Job.enqueue(UpdateMessageCounterJob.new(self.id, poster_id, version))
    end

    def new_room(version = 0)
      Delayed::Job.enqueue(AddRoomJob.new(self.id, version)) if self.private?
    end
  end
end
