# frozen_string_literal: true

class PostCommentMentionPushJob < ApplicationJob
  queue_as :default
  include Push

  # TODO: Make sure this is used.
  def perform(mention_id)
    post_comment_mention = PostCommentMention.find(mention_id)
    ActsAsTenant.with_tenant(post_comment_mention.post_comment.product) do
      post_comment_mention_push(post_comment_mention, post_comment_mention.person)
    end
  end

end
