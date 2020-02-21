class PostPushNotificationJob < Struct.new(:post_id)
  def perform
    post = Post.find(post_id)
    person = post.person
    ActsAsTenant.with_tenant(person.product) do
      Push::PostForFollowers.new.push(person, post.id)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      Rails.logger.warn("rnf on #{post_id}")
      job.destroy
    end
  end
end
