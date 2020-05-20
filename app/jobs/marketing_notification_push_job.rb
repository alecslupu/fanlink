# frozen_string_literal: true
class MarketingNotificationPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(notification_id, run_at)
    notification = MarketingNotification.find(notification_id)

    return unless notification.run_at.to_s == run_at

    ActsAsTenant.with_tenant(notification.product) do
      Push::Marketing.new.push(notification)
    end
  end
end
