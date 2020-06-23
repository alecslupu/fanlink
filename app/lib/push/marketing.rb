# frozen_string_literal: true

module Push
  class Marketing < BasePush
    BATCH_SIZE = 500.freeze

    def push(notification)
      @notification = notification
      case @notification.person_filter
      when 'has_free_certificates_enrolled'
          person_ids = Person.has_free_certificates_enrolled.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_free_certificates_enrolled'
          person_ids = Person.has_no_free_certificates_enrolled.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_certificates_generated'
          person_ids = Person.has_certificates_generated.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_paid_certificates'
          person_ids = Person.has_paid_certificates.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_paid_certificates'
          person_ids = Person.has_no_paid_certificates.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_friends'
          person_ids = Person.with_friendships.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_friends'
          person_ids = Person.without_friendships.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_followings'
          person_ids = Person.has_followings.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_followings'
          person_ids = Person.has_no_followings.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_interests'
          person_ids = Person.has_interests.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_interests'
          person_ids = Person.has_no_interests.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_created_posts'
          person_ids = Person.has_posts.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_created_posts'
          person_ids = Person.has_no_posts.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_facebook_id'
          person_ids = Person.has_facebook_id.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'account_created_past_24h'
          person_ids = Person.has_created_acc_past_24h.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'accoount_created_past_7_days'
          person_ids = Person.has_created_acc_past_7days.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'send_to_all'
          person_ids = Person.where.not(id: notification.person_id).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'has_no_sent_messages'
          person_ids = Person.has_no_sent_messages.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
            send_filtered_notification(person_ids)
          end
      when 'active_48h'
          person_ids = Person.active_48h.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
           send_filtered_notification(person_ids)
         end
      when 'active_7days'
          person_ids = Person.active_7days.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
           send_filtered_notification(person_ids)
         end
      when 'active_30days'
          person_ids = Person.active_30days.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
           send_filtered_notification(person_ids)
         end
      end
    end

    private

    def send_filtered_notification(person_ids)
      @target_people_ids = person_ids
      ios_token_notification_push(
        @notification.title,
        @notification.body,
        nil,
        @notification.ttl_hours * 3600,
        context: 'marketing',
        deep_link: @notification.deep_link
      )
      android_token_notification_push(
        @notification.ttl_hours * 3600,
        context: 'marketing',
        title: @notification.title,
        message_short: @notification.body,
        deep_link: @notification.deep_link,
        type: 'user'
      )
    end
  end
end
