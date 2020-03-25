class PostCommentMentionPushJob < Struct.new(:post_comment_mention_id)
  include Push

  def perform
    post_comment_mention = PostCommentMention.find(post_comment_mention_id)
    ActsAsTenant.with_tenant(post_comment_mention.post_comment.product) do
      post_comment_mention_push(post_comment_mention)
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
