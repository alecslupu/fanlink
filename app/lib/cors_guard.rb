class CorsGuard
  ALWAYS_ALLOW = %w[ https://www.fan.link https://staging.fan.link https://portal.dev.fanlinkmusic.com https://portal.fanlinkmusic.com ]

  ALWAYS_ALLOW << ENV["PORTAL_URL"] if ENV["PORTAL_URL"]

  def self.allow_from?(source)
    ALWAYS_ALLOW.include?(source) || !source.match('https://.*\.fan\.link').nil?
  end

end
