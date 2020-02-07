module Push
  class BasePush
    BATCH_SIZE = 500.freeze
    protected

    def push_client
      @fbcm ||= FCM.new(Rails.application.secrets.firebase_cm_key)
    end

    def disconnect
      @fbcm = nil
    end

    def push_with_retry(options, tokens, phone_os)
      resp = nil
      begin
        retries ||= 0
        # Rails.logger.error("Sending push with: tokens: #{tokens.inspect} and options: #{options.inspect}")
        resp = push_client.send(tokens.sort, options)
        # Rails.logger.error("Got FCM response: #{resp.inspect}")
        clean_notification_device_ids(resp[:not_registered_ids], phone_os) if resp.present?
      rescue Errno::EPIPE
        # FLAPI-839
        disconnect
        retry if (retries += 1) < 2
      end
      resp
    end

    def unsubscribe_to_topic(tokens, phone_os)
      tokens = tokens.is_a?(Array) ? tokens : [tokens]
      case phone_os
      when nil
        %w(marketing_en_ios-US marketing_en_android-US).each do |topic|
          response = push_client.batch_topic_unsubscription(topic, tokens)
        end
      when "android"
        response = push_client.batch_topic_unsubscription("marketing_en_android-US", tokens)
      when "ios"
        response = push_client.batch_topic_unsubscription("marketing_en_ios-US", tokens)
      end
    end

    def delete_not_registered_device_ids(device_ids)
      NotificationDeviceId.where(device_identifier: device_ids).destroy_all
    end

    def mark_not_registered_device_ids(device_ids)
      NotificationDeviceId.where(device_identifier: device_ids).update_all(not_registered: true)
    end


    def clean_notification_device_ids(resp, phone_os)
      delete_not_registered_device_ids(resp)
      mark_not_registered_device_ids(resp)
      unsubscribe_to_topic(resp, phone_os)
    end

    def ios_token_notification_push(title, body, click_action, ttl, data = {})
      if @target_person
        tokens = @target_person.ios_device_tokens
      elsif @target_people_ids
        tokens = NotificationDeviceId.where(person_id: @target_people_ids, device_type: :ios).pluck(:device_identifier)
      else
        tokens = []
      end

      return if tokens.empty?

      notification_body = build_ios_notification(title, body, click_action, ttl, data)
      if tokens.size <= BATCH_SIZE
        push_with_retry(notification_body, tokens, "ios")
      else
        tokens.each_slice(BATCH_SIZE) do |firebase_tokens|
          push_with_retry(notification_body, firebase_tokens, "ios")
        end
      end
    end

    def build_ios_notification(title, body, click_action, ttl, data = {})
      options = {}
      options[:notification] = {}

      options[:notification][:title] = title
      options[:notification][:body] = body
      options[:notification][:click_action] = click_action
      options[:notification][:sound] = "default"
      options[:notification][:mutable_content] = "true"

      options[:data] = data
      options[:data][:priority] = "high"
      options[:data][:time_to_live] = ttl

      return options
    end

    # TODO rename this
    def android_token_notification_push(ttl, data = {})
      if @target_person
        tokens = @target_person.android_device_tokens
      elsif @target_people_ids
        tokens = NotificationDeviceId.where(person_id: @target_people_ids, device_type: :android).pluck(:device_identifier)
      else
        tokens = []
      end

      return if tokens.empty?

      notification_body = build_android_notification(ttl, data)
      if tokens.size <= BATCH_SIZE
        push_with_retry(notification_body, tokens, "android")
      else
        tokens.each_slice(BATCH_SIZE) do |firebase_tokens|
          push_with_retry(notification_body, firebase_tokens, "android")
        end
      end
    end

    def build_android_notification(ttl, data = {})
      options = {}
      data[:type] = "user"
      options[:data] = data
      options[:priority] = "high"
      options[:content_available] = true
      options[:mutable_content] = true
      options[:time_to_live] = ttl

      # this may be used for v1 implementation
      # options[:android] = build_android_options

      return options
    end

    def notification_topic_push(topic, options)
      begin
        resp = push_client.send_to_topic(topic, options)
      rescue Errno::EPIPE
        disconnect
        retry if (retries += 1) < 2
      end
      resp
    end
  end
end
