# frozen_string_literal: true

if Rails.env.production? || Rails.env.staging?

else
  require 'httplog'
  HttpLog.configure do |config|
    # Enable or disable all logging
    config.enabled = true

    # You can assign a different logger or method to call on that logger
    config.logger = Rails.logger
    config.logger_method = :log

    # I really wouldn't change this...
    config.severity = Logger::Severity::DEBUG

    # Tweak which parts of the HTTP cycle to log...
    config.log_connect = true
    config.log_request = true
    config.log_headers = false
    config.log_data = true
    config.log_status = true
    config.log_response = true
    config.log_benchmark = true

    # ...or log all request as a single line by setting this to `true`
    config.compact_log = false

    # You can also log in JSON format
    config.json_log = false

    # Prettify the output - see below
    config.color = false

    # Limit logging based on URL patterns
    config.url_whitelist_pattern = nil
    config.url_blacklist_pattern = nil

    # Mask the values of sensitive requestparameters
    config.filter_parameters = %w[password]
  end
end
