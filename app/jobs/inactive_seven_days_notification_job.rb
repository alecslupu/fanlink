class InactiveSevenDaysNotificationJob
  BATCH_SIZE = 500.freeze

  def perform
    notification = AutomatedNotification.where(criteria: :inactive_48h, enabled: true).last

    return unless notification

    ActsAsTenant.with_tenant(notification.product) do
      NotificationDeviceId.joins(:person).where(device_type: :ios).where("people.last_activity_at > ? AND people.last_activity_at < ?", Time.zone.now - 7.day, Time.zone.now - 8.day).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |device_ids|
        Delayed::Job.enqueue(AutomatedNotificationIosPushJob.new(device_ids.pluck(:id), notification.title, notification.body, notification.ttl_hours))
      end

      NotificationDeviceId.joins(:person).where(device_type: :android).where("people.last_activity_at > ? AND people.last_activity_at < ?", Time.zone.now - 7.day, Time.zone.now - 8.day).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |device_ids|
        Delayed::Job.enqueue(AutomatedNotificationAndroidPushJob.new(device_ids.pluck(:id), notification.title, notification.body, notification.ttl_hours))
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end



