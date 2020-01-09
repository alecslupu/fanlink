class MarketingNotificationPushJob < Struct.new(:notification_id)
  include Push

  BATCH_SIZE = 50.freeze

  def perform
    notification = MarketingNotification.find(notification_id)

    ActsAsTenant.with_tenant(notification.product) do
      # current_user = notification.person
      marketing_notification_push(notification)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
