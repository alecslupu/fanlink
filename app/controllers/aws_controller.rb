class AwsController < ApplicationController
	#require_api_key_for :awsvideo

	#
	# This is the SNS callback for receiving notifications from Elastic
	# Transcoder. We only expect `SubscriptionConfirmation` and `Notification`
	# messages, anything else will raise an exception.
	#
	# Authentication is done through basic auth with an `ApiKey`
	#
	def video_transcoded
		type  = request.headers['x-amz-sns-message-type'].to_s.downcase
		topic = request.headers['x-amz-sns-topic-arn']
    body  = JSON.parse(request.raw_post)
    Rails.logger.error "----->Got #{type}"
		if(type == 'subscriptionconfirmation')
      Rails.logger.error "Away we go #{body['Token']}"
			Flaws.sns_confirm(topic, body['Token'])
		elsif(type == 'notification')
      Rails.logger.error body['Message']
			Post.process_et_response(JSON.parse(body['Message']))
		else
			raise 'Unknown message type'
		end
		render :nothing => true, :status => :ok
	rescue Aws::SNS::Errors::ServiceError, ArgumentError, RuntimeError => e
		Rails.logger.error "SNS confusion, topic=#{topic}, type=#{type}, params=#{params.inspect}, error=#{e.inspect}, body.Message=#{JSON.parse(body['Message']).inspect}"
		render :nothing => true, :status => :unprocessable_entity
	end
  skip_before_action :require_login
end
