# frozen_string_literal: true

class SimpleNotificationPushJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 500.freeze

  def perform(notification_id)
    notification = Notification.find(notification_id)
    ActsAsTenant.with_tenant(notification.product) do
      current_user = notification.person

      if notification.for_followers
        current_user.followers.select(:id).find_in_batches(batch_size: BATCH_SIZE) do |receipents|
          Push::SimpleNotification.new.push(notification, current_user, receipents.pluck(:id))
        end
      else
        Person.where.not(id: current_user.id).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |receipents|
          Push::SimpleNotification.new.push(notification, current_user, receipents.pluck(:id))
        end
      end
    end
  end
end
