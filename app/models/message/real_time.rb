class Message
  module RealTime
    def post
      Delayed::Job.enqueue(PostMessageJob.new(self.id))
    end

  end
end