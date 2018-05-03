class PostComment
  module RealTime
    def post
      post_comment_mentions.each do |m|
        Delayed::Job.enqueue(PostCommentMentionPushJob.new(m.id))
      end
    end
  end
end
