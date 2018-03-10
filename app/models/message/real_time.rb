class Message
  module RealTime

    def delete_real_time
      Delayed::Job.enqueue(DeleteMessageJob.new(self.id))
    end

    def post
      Delayed::Job.enqueue(PostMessageJob.new(self.id))
    end

  end
end