# frozen_string_literal: true

class PostPostJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(post_id, version = 0)
    post = Post.find(post_id)
    followers = post.person.followers
    return if followers.size == 0
    payload = {}
    followers.each do |f|
      payload["#{user_path(f)}/last_post_id"] = post_id
      if version.present?
        version.downto(1) { |v|
          payload["#{versioned_user_path(f, v)}/last_post_id"] = post_id
        }
      end
    end
    client.update('', payload)
  end
end
