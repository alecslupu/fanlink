class Post
  module RealTime
    def delete_real_time(version = 0)
      Delayed::Job.enqueue(DeletePostJob.new(self.id, version))
    end

    def post(version = 0)
      Delayed::Job.enqueue(PostPostJob.new(self.id, version))
      if notify_followers && (person.followers.count > 0)
        Delayed::Job.enqueue(PostPushNotificationJob.new(self.id))
      end
    end
  end
end
