Rails.application.config.session_store :redis_store, {
  servers: [
    { host: ENV["REDIS_HOST"], port: 6379, db: 0, serializer: JSON },
  ],
  key: "_fanlink_session",
  expire_after: 14.days
}
