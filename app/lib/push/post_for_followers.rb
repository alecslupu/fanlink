# frozen_string_literal: true

module Push
  class PostForFollowers < BasePush

    def push(person, post_id)
      @target_people_ids = person.followers.pluck(:id)

      android_token_notification_push(
        2419200,
        context: 'feed_post',
        title: 'New post',
        message_short: "New post from #{person.username}",
        message_placeholder: person.username,
        deep_link: "#{person.product.internal_name}://posts/#{post_id}/comments",
        type: 'user'
      )

      ios_token_notification_push(
        'New Post',
        "New post from #{person.username}",
        nil,
        2419200,
        context: 'feed_post',
        deep_link: "#{person.product.internal_name}://posts/#{post_id}/comments"
      )
    end
  end
end

