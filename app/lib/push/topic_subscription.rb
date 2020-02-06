module Push
  class TopicSubscription < BasePush
    # will be later changed to accept language to unsubscribe to the correct marketing topic
    def subscribe_device(device_identifier, device_type)
      response = push_client.topic_subscription(get_topic(device_type), device_identifier)
    end

    # will be later changed to accept language to unsubscribe to the correct marketing topic
    def unsubscribe_device(device_identifier, device_type)
      response = push_client.batch_topic_unsubscription(get_topic(device_type), [device_identifier])
    end

    private

      def get_topic(device_type)
        if device_type == "ios"
          return "marketing_en_ios-US"
        elsif device_type == "android"
          return "marketing_en_android-US"
        end
      end
  end
end
