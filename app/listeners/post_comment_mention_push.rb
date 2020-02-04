class PostCommentMentionPush < BaseMention
  include Push

  def self.post_comment_created(post_comment_id, product_id)
    post_comment = PostComment.find(post_comment_id)
    if post_comment.body
      mentions = self.parse_content(post_comment.body, product_id)
      if mentions
        mentions.each do |mentioned|
          blocks_with = post_comment.person.blocks_with.map { |b| b.id }
          message_mention_push(post_comment, mentioned) unless blocks_with.include?(mentioned.id)
        end
      end
    end
  end
end
