module Push
  class PostCommentMention < BasePush

    def push(post_comment, mentioned_person)
      @target_person = mentioned_person

      android_token_notification_push(
        2419200,
        context: "comment_mentioned",
        title: "Mention",
        message_short: "#{post_comment.person.username} mentioned you",
        message_placeholder: post_comment.person.username,
        deep_link: "#{post_comment.person.product.internal_name}://posts/#{post_comment.post.id}/comments"
      )

      ios_token_notification_push(
        "Mention",
        "#{post_comment.person.username} mentioned you",
        nil,
        2419200,
        context: "comment_mentioned",
        deep_link: "#{post_comment.person.product.internal_name}://posts/#{post_comment.post.id}/comments"
      )
    end
  end
end
