# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['sidekiqadmin', 'yourpassword']
end

Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
Sidekiq::Web.set :sessions, false

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url, db: 1 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url, db: 1 }
end
