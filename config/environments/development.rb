# frozen_string_literal: true
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.action_controller.action_on_unpermitted_parameters = :log


  # Do not eager load code on boot.
  config.eager_load = false

  config.enable_dependency_loading = true

  # Show full error reports.
  config.consider_all_requests_local = true


  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.enable_fragment_cache_logging = true
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    # config.cache_store = :memory_store
    config.cache_store = :redis_store, "#{Rails.application.secrets.redis_url}/0/cache", { expires_in: 90.minutes.to_i }
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  config.debug_exception_response_format = :api

  # ActiveSupport::Notifications.subscribe(/cache*+active_support/) do |name, start, finish, id, payload|
  #   Rails.logger.debug ["cache:", name, finish - start, id, payload].join(" ")
  # end

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::FileUpdateChecker

  config.web_console.whitelisted_ips = "172.16.0.0/12"

  #     #load openapi files
  # Dir['app/controllers/api/v*/docs/*'].each {
  #   |p| config.eager_load_paths << p
  # }

  config.after_initialize do
    Bullet.enable = true
    # Bullet.bullet_logger = true
    Bullet.rails_logger = true
  end

  # for page caching
  config.action_controller.perform_caching = true
  config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"

end
