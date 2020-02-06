module Push
  class FriendRequestAccepted < BasePush

    def push(relationship)
      @target_person = relationship.requested_by
      requested_to = relationship.requested_to

      if relationship.friended?
        android_token_notification_push(
          2419200,
          context: "friend_accepted",
          title: "Friend request accepted by #{requested_to.username}",
          message_short: "Friend request accepted by #{requested_to.username}",
          message_placeholder: requested_to.username,
          deep_link: "#{requested_to.product.internal_name}://users/#{requested_to.id}/profile"
        )

        ios_token_notification_push(
          "Friend request accepted",
          "Friend request accepted by #{requested_to.username}",
          nil,
          2419200,
          context: "friend_accepted",
          deep_link: "#{requested_to.product.internal_name}://users/#{requested_to.id}/profile"
        )
      end
    end
  end
end
