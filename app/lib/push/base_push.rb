# frozen_string_literal: true

module Push
  class BasePush
    BATCH_SIZE = 500.freeze

    def subscribe_user_to_topic(person_id, resource_id)
      ['ios', 'android'].each do |device_type|
        device_identifiers = get_device_identifiers(person_id, device_type)
        response = push_client.batch_topic_subscription("trivia_game_#{resource_id}_#{device_type}", device_identifiers) if device_identifiers.present?
      end
    end

    def unsubscribe_user_from_topic(person_id, resource_id)
      ['ios', 'android'].each do |device_type|
        device_identifiers = get_device_identifiers(person_id, device_type)
        response = push_client.batch_topic_unsubscription("trivia_game_#{resource_id}_#{device_type}", device_identifiers) if device_identifiers.present?
      end
    end

    # def unsubscribe_users_from_topic(person_ids, resource_id)
    #   response = push_client.batch_topic_unsubscription(get_topic(device_type), [device_identifier])
    # end

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

    def delete_not_registered_device_ids(device_ids)
      NotificationDeviceId.where(device_identifier: device_ids).destroy_all
    end

    def mark_not_registered_device_ids(device_ids)
      NotificationDeviceId.where(device_identifier: device_ids).update_all(not_registered: true)
    end

    def clean_notification_device_ids(resp, phone_os)
      delete_not_registered_device_ids(resp)
      mark_not_registered_device_ids(resp)
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
        push_with_retry(notification_body, tokens, 'ios')
      else
        tokens.each_slice(BATCH_SIZE) do |firebase_tokens|
          push_with_retry(notification_body, firebase_tokens, 'ios')
        end
      end
    end

    def build_ios_notification(title, body, click_action, ttl, data = {})
      options = {}
      options[:notification] = {}

      options[:notification][:title] = title
      options[:notification][:body] = body
      options[:notification][:click_action] = click_action
      options[:notification][:mutable_content] = 'true'
      options[:notification][:sound] = 'default'

      options[:data] = data
      options[:data][:priority] = 'high'
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
        push_with_retry(notification_body, tokens, 'android')
      else
        tokens.each_slice(BATCH_SIZE) do |firebase_tokens|
          push_with_retry(notification_body, firebase_tokens, 'android')
        end
      end
    end

    def build_android_notification(ttl, data = {})
      options = {}
      options[:data] = data
      options[:priority] = 'high'
      options[:content_available] = true
      options[:mutable_content] = true
      options[:time_to_live] = ttl

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

    def android_topic_notification_push(data, ttl, topic)
      notification_body = build_android_notification(ttl, data)
      response = push_client.send_to_topic(topic, notification_body)
    end

    def ios_topic_notification_push(title, body, ttl, topic, data = {})
      notification_body = build_ios_topic_notification(title, body, ttl, data)
      response = push_client.send_to_topic(topic, notification_body)
    end

    def build_ios_topic_notification(title, body, ttl, data)
      options = {}
      options[:notification] = {}

      options[:notification][:title] = title
      options[:notification][:body] = body
      options[:notification][:sound] = 'default'

      options[:data] = data
      options[:data][:priority] = 'high'
      options[:data][:time_to_live] = ttl

      return options
    end

    private

    def get_device_identifiers(person_id, device_type)
      NotificationDeviceId.where(person_id: person_id, device_type: device_type).pluck(:device_identifier)
    end
  end
end
