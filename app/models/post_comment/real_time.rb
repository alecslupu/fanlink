class PostComment
  module RealTime
    def post_me
      post_comment_mentions.each do |mention|
        Rails.logger.debug("mention: #{mention.inspect}")
        Delayed::Job.enqueue(PostCommentMentionPushJob.new(mention.id))
      end
    end
  end
end
