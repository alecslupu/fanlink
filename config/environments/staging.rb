# require "json"

Rails.application.configure do
  config.web_console.development_only = false
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  config.cache_store = :redis_store, "#{Rails.application.secrets.redis_url}/0/cache", {expires_in: 30.minutes}

  # Disable full error reports.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.logger = Logger.new(STDOUT)
  config.log_level = :info

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # This is the default, I'll leave it here as a reminder though.
  config.action_controller.action_on_unpermitted_parameters = false

  config.debug_exception_response_format = :api

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.digest = true
  config.assets.js_compressor = :uglifier

  config.redis_url = "#{Rails.application.secrets.redis_url}/0"

  config.eager_load = true
  config.force_ssl = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.web_console.whitelisted_ips = "172.30.0.0/12"

  config.after_initialize do
    Bullet.enable = true
    # Bullet.bullet_logger = true
    Bullet.rails_logger = true
    # Bullet.rollbar = true
  end
end
