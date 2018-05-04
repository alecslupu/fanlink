class PostPushNotificationJob < Struct.new(:post_id)
  include Push

  def perform
    post = Post.find(post_id)
    ActsAsTenant.with_tenant(post.person.product) do
      if post.notify_followers
        Rails.logger.warn("pushing post #{post.inspect} with post_id: #{post_id}")
        post_push(post)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
