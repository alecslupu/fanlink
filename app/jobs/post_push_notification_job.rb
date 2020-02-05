class PostPushNotificationJob < Struct.new(:post_id)
  include Push

  def perform
    post = Post.find(post_id)
    person = post.person
    ActsAsTenant.with_tenant(person.product) do
      if post.notify_followers && person.followers.exists?
        Push::Post.new.push(person, post.id)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      Rails.logger.warn("rnf on #{post_id}")
      job.destroy
    end
  end
end
