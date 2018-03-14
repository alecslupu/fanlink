class DeletePostJob < Struct.new(:post_id)
  include RealTimeHelpers

  def perform
    post = Post.find(post_id)
    if post.deleted?
      followers = post.person.followers
      if followers.size > 0
        payload = {}
        followers.each do |f|
          payload["#{user_path(f)}/deleted_post_id"] = post_id
        end
        client.update("", payload)
      end
    end
  end
end
