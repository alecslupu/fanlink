class PostPostJob < Struct.new(:post_id)
  include RealTimeHelpers

  def perform
    post = Post.find(post_id)
    followers = post.person.followers
    if followers.size > 0
      payload = {}
      followers.each do |f|
        payload["#{user_path(f)}/last_post_id"] = post_id
      end
      client.update("", payload)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
