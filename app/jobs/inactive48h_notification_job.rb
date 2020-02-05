class Inactive48hNotificationJob
  BATCH_SIZE = 50.freeze

  def perform
    notification = AutomatedNotification.where(criteria: :inactive_48h, enabled: true).last
    ActsAsTenant.with_tenant(notification.product) do
      NotificationDeviceId.joins(:person).where(device_type: :ios).where("people.last_activity_at > ? AND people.last_activity_at < ?",Time.zone.now - 51.hour, Time.zone.now - 48.hour).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |device_ids|
        Delayed::Job.enqueue(AutomatedNotificationIosPushJob.new(device_ids.pluck(:id), notification.title, notification.body, notification.ttl_hours))
      end

      NotificationDeviceId.joins(:person).where(device_type: :android).where("people.last_activity_at > ? AND people.last_activity_at < ?",Time.zone.now - 51.hour, Time.zone.now - 48.hour).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |device_ids|
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



