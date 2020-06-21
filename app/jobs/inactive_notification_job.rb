# frozen_string_literal: true

class InactiveNotificationJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 500.freeze

  def perform
    notification = AutomatedNotification.where(criteria: criteria, enabled: true).last

    return unless notification

    ActsAsTenant.with_tenant(notification.product) do
      Person.where("last_activity_at > ? AND last_activity_at < ?", start_time, end_time).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
        AutomatedNotificationPushJob.perform_later(notification.id, person_ids.uniq.pluck(:id))
      end
    end
  end

  protected
  def criteria
    raise "Not implemented"
  end

  def start_time
    raise "Not implemented"
  end

  def end_time
    raise "Not implemented"
  end
end
