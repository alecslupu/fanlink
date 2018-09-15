Rails.application.config.session_store :redis_store, {
  servers: [
    { host: ENV["REDIS_URL"], db: 0, serializer: JSON },
  ],
  key: "_fanlink_session",
  expire_after: 14.days
}
