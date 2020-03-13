# if Rack::Timeout.respond_to?(:timeout)
#   Rack::Timeout.timeout = 25 # seconds
# else
#   Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: 25 # seconds
# end
