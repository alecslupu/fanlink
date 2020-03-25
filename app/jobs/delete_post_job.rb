class DeletePostJob < Struct.new(:post_id, :version)
  include RealTimeHelpers

  def perform
    post = Post.find(post_id)
    if post.deleted?
      followers = post.person.followers
      if followers.size > 0
        payload = {}
        followers.each do |f|
          payload["#{user_path(f)}/deleted_post_id"] = post_id
          if version.present?
            version.downto(1) { |v|
              payload["#{versioned_user_path(f, v)}/deleted_post_id"] = post_id
            }
          end
        end
        client.update("", payload)
      end
    end
  end

  def queue_name
    :default
  end
end
