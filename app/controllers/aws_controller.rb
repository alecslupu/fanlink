# frozen_string_literal: true

class AwsController < ApplicationController
  # require_api_key_for :awsvideo

  skip_before_action :require_login
  #
  # This is the SNS callback for receiving notifications from Elastic
  # Transcoder. We only expect `SubscriptionConfirmation` and `Notification`
  # messages, anything else will raise an exception.
  #
  # Authentication is done through basic auth with an `ApiKey`
  #
  def video_transcoded
    type = request.headers['x-amz-sns-message-type'].to_s.downcase
    topic = request.headers['x-amz-sns-topic-arn']
    body = JSON.parse(request.raw_post)
    if type == 'subscriptionconfirmation'
      Flaws.sns_confirm(topic, body['Token'])
    elsif type == 'notification'
      Post.process_et_response(JSON.parse(body['Message']))
    else
      raise 'Unknown message type'
    end
    head :ok
  rescue Aws::SNS::Errors::ServiceError, ArgumentError, RuntimeError => e
    Rails.logger.error "SNS confusion, topic=#{topic}, type=#{type}, params=#{params.inspect}, error=#{e.inspect}, body.Message=#{body['Message']}"
    head :unprocessable_entity
  end
end
