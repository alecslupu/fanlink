Rails.application.config.to_prepare do
  Wisper.configure do |config|
    config.broadcaster :default, Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger,  Wisper::Broadcasters::SendBroadcaster.new)
    # config.broadcaster :async,   Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger,  Wisper::Broadcasters::SidekiqBroadcaster.new) # if using async
  end
  Wisper.clear if Rails.env.development?
  Wisper.subscribe(QuestsListener)
  Wisper.subscribe(RewardsListener)
  Wisper.subscribe(LevelsListener)
end
