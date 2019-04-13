require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
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
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.paperclip_defaults = {
        storage: :s3,
        url: "/system/:product/:class/:attachment/:id_partition/:style/:hash.:extension",
        s3_region: ENV["AWS_REGION"],
        bucket:    ENV["AWS_BUCKET"],
        hash_secret: ENV["PAPERCLIP_SECRET"],
        s3_host_name: "s3.#{ENV.fetch('AWS_REGION')}.amazonaws.com",
        s3_credentials: {
            access_key_id: ENV["AWS_ACCESS_KEY_ID"],
            secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
        },
        s3_protocol: :https
    }

    config.mandrill_mailer.default_url_options = { host: ENV["MAILER_APP_URL"] || "www.fan.link" }


    config.middleware.insert_before 0, Rack::Cors do
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
  end
end
