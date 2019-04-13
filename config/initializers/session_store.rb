Rails.application.config.session_store :redis_store,
  servers: [ "#{ENV['REDIS_URL']}/0/session" ],
  key: "_fanlink_session",
  expire_after: 14.days.to_i
