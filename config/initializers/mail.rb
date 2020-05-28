# frozen_string_literal: true
MandrillMailer.configure do |config|
  config.api_key = Rails.application.secrets.mandrill_api_key
  config.deliver_later_queue_name = :default
end
