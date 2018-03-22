class CorsGuard
  #TODO use redis or something for better thread safety
  ALWAYS_ALLOW = %w[ https://www.fan.link https://staging.fan.link ]
  CORS_KEY = "cors_allowed"

  def self.allow_from?(source)
    Rails.cache.fetch(CORS_KEY, expires_in: 5.minutes) do
      ALWAYS_ALLOW + Product.enabled.pluck(:internal_name).map { |n| "https://#{n}.fan.link" }
    end.include?(source)
  end

  def self.invalidate
    Rails.cache.delete(CORS_KEY)
  end
end
