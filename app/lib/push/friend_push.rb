module Push
  class FriendPush < BasePush

    def friend_request_accepted_push(relationship)
      to = relationship.requested_to
      from = relationship.requested_by

      target_person = from

      return unless relationship.friended?

      android_token_notification_push(
        2419200,
        context: "friend_accepted",
        title: "Friend request accepted by #{to.username}",
        message_short: "Friend request accepted by #{to.username}",
        message_placeholder: to.username,
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      )

      ios_token_notification_push(
        "Friend request accepted",
        "Friend request accepted by #{to.username}",
        nil,
        2419200,
        context: "friend_accepted",
        deep_link: "#{from.product.internal_name}://users/#{to.id}"
      )
    end

    def friend_request_received_push(relationship)
      from = relationship.requested_by
      to = relationship.requested_to
      target_person = to

      profile_picture_url = from.picture_url.present? ? from.picture_url : from.facebook_picture_url
      android_token_notification_push(
        2419200,
        context: "friend_requested",
        title: "Friend request",
        message_short: "New friend request from #{from.username}",
        message_placeholder: from.username,
        image_url: profile_picture_url,
        relationship_id: relationship.id,
        deep_link: "#{from.product.internal_name}://users/#{from.id}"
      )

      ios_token_notification_push(
        "Friend request",
        "New friend request from #{from.username}",
        "AcceptOrIgnore",
        2419200,
        context: "friend_requested",
        relationship_id: relationship.id,
        image_url: profile_picture_url,
        deep_link: "#{from.product.internal_name}://users/#{from.id}"
      )
    end
  end
end
