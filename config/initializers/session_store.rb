Rails.application.config.session_store :redis_store,
  servers: ["#{Rails.application.secrets.redis_url}/0/session"],
  key: "_fanlink_session",
  expire_after: 14.days.to_i
