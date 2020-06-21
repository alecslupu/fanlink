# frozen_string_literal: true

class PortalNotificationPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(portal_notification_id)
    portal_notification = PortalNotification.find(portal_notification_id)

    return unless portal_notification.pending?
    return if portal_notification.future_send_date?

    ActsAsTenant.with_tenant(portal_notification.product) do
      portal_notification_push(portal_notification)
    end
  end
end
