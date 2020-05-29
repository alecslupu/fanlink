# frozen_string_literal: true
require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_storage/engine"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "./app/middleware/sns_content_type"

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fanlink
  class Application < Rails::Application
    log_dest = ENV["HEROKU"].present? ? STDOUT : "log/#{Rails.env}.log"

    logger = ActiveSupport::Logger.new(log_dest)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)


    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    # config.paperclip_defaults = {
    #     storage: :s3,
    #     url: "/system/:product/:class/:attachment/:id_partition/:style/:hash.:extension",
    #     s3_region: Rails.application.secrets.aws_region,
    #     bucket:    Rails.application.secrets.aws_bucket,
    #     hash_secret: Rails.application.secrets.paperclip_secret,
    #     s3_host_name: "s3.#{Rails.application.secrets.aws_region}.amazonaws.com",
    #     s3_credentials: {
    #         access_key_id: Rails.application.secrets.aws_access_key_id,
    #         secret_access_key: Rails.application.secrets.aws_secret_access_key
    #     },
    #     s3_protocol: :https
    # }


    # config.paperclip_defaults = {
    #   path: ":rails_root/test_uploads/:class/:id/:attachment/:filename.:extension",
    #   url: ":rails_root/test_uploads/:class/:id/:attachment/:filename.:extension"
    # } if Rails.env.test?

    # config.mandrill_mailer.default_url_options = { host: ENV["MAILER_APP_URL"] || "www.fan.link" }


    config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> {Rails.logger}) do
      allow do
        origins do |source, env|
          if ENV["RAILS_ENV"] != "development"
            CorsGuard.allow_from?(source)
          else
            true
          end
        end
        resource "*", headers: :any, methods: :any, credentials: true, expose: %i[ Per-Page Link Total ]
      end
    end
    # config.middleware.insert_before ActionDispatch::Static, SnsContentType
    config.i18n.default_locale = :en
    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"

    config.fanlink = {
      aws: {
        hls_server: Rails.application.secrets.hls_server,
        rtmp_server: Rails.application.secrets.rtmp_server,
        transcoder_key: Rails.application.secrets.aws_transcoder_key,
        transcoder_secret: Rails.application.secrets.aws_transcoder_secret,
        s3_bucket:  Rails.application.secrets.aws_bucket,
        transcoder_pipeline_id: Rails.application.secrets.aws_pipeline_id,
        region: Rails.application.secrets.aws_region,
        transcoder_queue_url: Rails.application.secrets.transcoder_queue_url
      }
    }

     #Use a real queuing backend for Active Job (and separate queues per environment)
     config.active_job.queue_adapter     = :sidekiq
     #config.active_job.queue_name_prefix = "fanlink_#{Rails.env}"
     #

    config.i18n.fallbacks = [I18n.default_locale]

    config.active_storage.service = :amazon

    config.session_store :redis_store,
                         servers: ["#{Rails.application.secrets.redis_url}/0/session"],
                         key: "_fanlink_session",
                         expire_after: 14.days.to_i


    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :user_name => Rails.application.secrets.smtp_user_name,
      :password => Rails.application.secrets.smtp_password,
      :address => Rails.application.secrets.smtp_host,
      :domain => Rails.application.secrets.smtp_domain,
      :port => Rails.application.secrets.smtp_port,
      :authentication => Rails.application.secrets.smtp_authentication
    }

    config.active_storage.variant_processor = :mini_magick
  end
end
