# frozen_string_literal: true

Rails.application.config.to_prepare do
  Wisper.configure do |config|
    logger = Wisper::Broadcasters::LoggerBroadcaster.new(Rails.logger, Wisper::Broadcasters::SendBroadcaster.new)
    config.broadcaster :default, logger
  end
  Wisper.clear if Rails.env.development?
  Wisper::ActiveRecord.extend_all
  Wisper.subscribe(MessageMentionPush, async: true)
  Wisper.subscribe(UserReferredListener, async: true)
  Wisper.subscribe(QuestsListener)
  Wisper.subscribe(RewardsListener)
  Wisper.subscribe(LevelsListener)
  Wisper.subscribe(TagsListener)
  Wisper.subscribe(UpdateTagPostsCount)
  Wisper.subscribe(PostCommentMentionPush, async: true)
end
