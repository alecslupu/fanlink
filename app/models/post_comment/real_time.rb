class PostComment
  module RealTime
    def post_me
      post_comment_mentions.each do |m|
        Rails.logger.debug("mention: #{m.inspect}")
        Delayed::Job.enqueue(PostCommentMentionPushJob.new(m.id))
      end
    end
  end
end
