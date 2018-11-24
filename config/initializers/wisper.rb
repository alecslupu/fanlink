Rails.application.config.to_prepare do
  Wisper.configure do |config|
    config.broadcaster :default, Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger,  Wisper::Broadcasters::SendBroadcaster.new)
    # config.broadcaster :async,   Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger,  Wisper::Broadcasters::SidekiqBroadcaster.new) # if using async
  end
  Wisper.clear if Rails.env.development?
  Wisper::ActiveRecord.extend_all
  Wisper.subscribe(MentionPushNotification.new, async: true)
  Wisper.subscribe(QuestsListener.new)
  Wisper.subscribe(RewardsListener.new)
  Wisper.subscribe(LevelsListener.new)
  Wisper.subscribe(TagsListener.new)
  Wisper.subscribe(UpdateTagPostsCount.new)
end
