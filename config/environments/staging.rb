require "json"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Disable full error reports.
  config.consider_all_requests_local = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::ERROR

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new


  # This is the default, I'll leave it here as a reminder though.
  config.action_controller.action_on_unpermitted_parameters = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.assets.digest = true
  config.assets.js_compressor = :uglifier

  config.redis_url = "#{ENV['REDIS_URL']}/stagerank"
  config.eager_load = true
  config.force_ssl = true
  config.public_file_server.enabled = true

end
