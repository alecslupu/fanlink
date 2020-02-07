module Push
  class Marketing < BasePush
    def push(notification)
      if notification.send_to_all?
        send_notification_to_all(notification)
      else
        send_filtered_notification(notification)
      end
    end

    private

      def send_notification_to_all(notification)

        android_notification_body = build_android_notification(
                                      notification.ttl_hours * 3600,
                                      context: "marketing",
                                      title: notification.title,
                                      message_short: notification.body,
                                      deep_link: notification.deep_link
                                    )

        ios_notification_body = build_ios_notification(
                                  notification.title,
                                  notification.body,
                                  nil,
                                  notification.ttl_hours * 3600,
                                  context: "marketing",
                                  deep_link: notification.deep_link
                                )

        notification_topic_push("marketing_en_ios-US", ios_notification_body)
        notification_topic_push("marketing_en_android-US", android_notification_body)
      end

      def send_filtered_notification(notification)
        person_ids = get_person_ids(notification)

        NotificationDeviceId.where(person_id: person_ids, device_type: :ios).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
          ios_token_notification_push(
            notification_device_ids.pluck(:device_identifier),
            notification.title,
            notification.body,
            nil,
            notification.ttl_hours * 3600,
            context: "marketing",
            deep_link: notification.deep_link
          )
        end

        NotificationDeviceId.where(person_id: person_ids, device_type: :android).select(:id, :device_identifier).find_in_batches(batch_size: BATCH_SIZE) do |notification_device_ids|
          android_token_notification_push(
            notification_device_ids.pluck(:device_identifier),
            notification.ttl_hours * 3600,
            context: "marketing",
            title: notification.title,
            message_short: notification.body,
            deep_link: notification.deep_link
          )
        end
      end

      def get_person_ids
        case notification.person_filter
         when "has_certificate_enrolled"
           person_ids = Person.has_enrolled_certificate.select(:id)
         when "has_no_certificate_enrolled"
           person_ids = Person.has_no_enrolled_certificate.select(:id)
         when "has_certificate_generated"
           person_ids = Person.has_certificate_generated.select(:id)
         when "has_paid_certificate"
           person_ids = Person.has_paid_certificate.select(:id)
         when "has_no_paid_certificate"
           person_ids = Person.has_no_paid_certificate.select(:id)
         when "has_friends"
           person_ids = Person.with_friendships.select(:id)
         when "has_no_friends"
           person_ids = Person.without_friendships.select(:id)
         when "has_followings"
           person_ids = Person.has_followings.select(:id)
         when "has_no_followings"
           person_ids = Person.has_no_followings.select(:id)
         when "has_interests"
           person_ids = Person.has_interests.select(:id)
         when "has_no_interests"
           person_ids = Person.has_no_interests.select(:id)
         when "has_created_posts"
           person_ids = Person.has_posts.select(:id)
         when "has_no_created_posts"
           person_ids = Person.has_no_posts.select(:id)
         when "has_facebook_id"
           person_ids = Person.has_facebook_id.select(:id)
         when "account_created_past_24h"
           person_ids = Person.has_created_acc_past_24h.select(:id)
         when "accoount_created_past_7_days"
           person_ids = Person.has_created_acc_past_7days.select(:id)
         end

         return person_ids
      end
  end
end
