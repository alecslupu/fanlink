module Push
  class FriendRequestReceived < BasePush

    def push(relationship)
      @target_person = relationship.requested_to
      requested_by_person = relationship.requested_by
      profile_picture_url = requested_by_person.picture_url.present? ? requested_by_person.picture_url : requested_by_person.facebook_picture_url

      android_token_notification_push(
        2419200,
        context: "friend_requested",
        title: "Friend request",
        message_short: "New friend request from #{requested_by_person.username}",
        message_placeholder: requested_by_person.username,
        image_url: profile_picture_url,
        relationship_id: relationship.id,
        deep_link: "#{requested_by_person.product.internal_name}://users/#{requested_by_person.id}/profile"
      )

      ios_token_notification_push(
        "Friend request",
        "New friend request from #{requested_by_person.username}",
        "AcceptOrIgnore",
        2419200,
        context: "friend_requested",
        relationship_id: relationship.id,
        image_url: profile_picture_url,
        deep_link: "#{requested_by_person.product.internal_name}://users/#{requested_by_person.id}/profile"
      )
    end
  end
end

