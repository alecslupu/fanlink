# frozen_string_literal: true

class CorsGuard
  ALWAYS_ALLOW = %w(
    https://www.fan.link
    https://fan.link
    https://staging.fan.link
    https://portal.dev.fanlinkmusic.com
    https://portal.staging.fanlinkmusic.com
    https://portal.fanlinkmusic.com
    https://portal.fanmusiclink.com

    https://can-ed.com
    https://www.can-ed.com
    https://courses.can-ed.com
    https://staging.can-ed.com

    http://alecslupu.go.ro
    http://alecslupu.go.ro:8082
  )

  if ENV['PORTAL_URL']
    ENV['PORTAL_URL'].split(',').each do |url|
      # TODO Add URL verification here
      ALWAYS_ALLOW << url
    end
  end

  def self.allow_from?(source)
    ALWAYS_ALLOW.include?(source) || !source.match('https://.*\.fan\.link').nil?
  end
end
