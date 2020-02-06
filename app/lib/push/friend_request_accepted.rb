module Push
  class FriendRequestAccepted < BasePush

    def push(relationship)
      @target_person = relationship.requested_by

      if relationship.friended?
        android_token_notification_push(
          2419200,
          context: "friend_accepted",
          title: "Friend request accepted by #{@target_person.username}",
          message_short: "Friend request accepted by #{@target_person.username}",
          message_placeholder: @target_person.username,
          deep_link: "#{@target_person.product.internal_name}://users/#{@target_person.id}/profile"
        )

        ios_token_notification_push(
          "Friend request accepted",
          "Friend request accepted by #{@target_person.username}",
          nil,
          2419200,
          context: "friend_accepted",
          deep_link: "#{@target_person.product.internal_name}://users/#{@target_person.id}/profile"
        )
      end
    end
  end
end
