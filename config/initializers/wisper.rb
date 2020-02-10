Rails.application.config.to_prepare do
  Wisper.configure do |config|
    config.broadcaster :default, Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger, Wisper::Broadcasters::SendBroadcaster.new)
    # config.broadcaster :async,   Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger,  Wisper::Broadcasters::ActiveJobBroadcaster.new) # if using async
  end
  Wisper.clear if Rails.env.development?
  Wisper::ActiveRecord.extend_all
  Wisper.subscribe(MentionPushNotification, async: true)
  Wisper.subscribe(UserReferredListener, async: true)
  Wisper.subscribe(QuestsListener)
  Wisper.subscribe(RewardsListener)
  Wisper.subscribe(LevelsListener)
  Wisper.subscribe(TagsListener)
  Wisper.subscribe(UpdateTagPostsCount)
end
