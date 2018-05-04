class Post
  module RealTime
    def delete_real_time
      Delayed::Job.enqueue(DeletePostJob.new(self.id))
    end

    def post
      Delayed::Job.enqueue(PostPostJob.new(self.id))
      if post.notify_followers && (post.person.followers.count > 0)
        Delayed::Job.enqueue(PostPushNotificationJob.new(post.id))
      end
    end
  end
end
