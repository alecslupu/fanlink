class PostPushNotificationJob < Struct.new(:post_id)
  include Push

  def perform
    Rails.logger.warn("performing push on post id #{post_id}")
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
      Rails.logger.warn("rnf on #{post_id}")
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
