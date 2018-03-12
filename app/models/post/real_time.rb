class Post
  module RealTime
    def delete_real_time
      Delayed::Job.enqueue(DeletePostJob.new(self.id))
    end

    def post
      Delayed::Job.enqueue(PostPostJob.new(self.id))
    end
  end
end
