class PostPostJob < Struct.new(:post_id, :version)
  include RealTimeHelpers

  def perform
    post = Post.find(post_id)
    followers = post.person.followers
    if followers.size > 0
      payload = {}
      followers.each do |f|
        payload["#{user_path(f)}/last_post_id"] = post_id
        if version.present?
          version.downto(1) { |v|
            payload["#{versioned_user_path(f, v)}/last_post_id"] = post_id
          }
        end
      end
      client.update("", payload)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
