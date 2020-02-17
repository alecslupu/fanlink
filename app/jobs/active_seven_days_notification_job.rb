class ActiveSevenyDaysNotificationJob
  BATCH_SIZE = 500.freeze

  def perform
    notification = AutomatedNotification.where(criteria: :active_7days, enabled: true).last

    return unless notification

    ActsAsTenant.with_tenant(notification.product) do
      Person.where("last_activity_at > ? AND last_activity_at < ?", Time.zone.now - 6.day, Time.zone.now - 7.day).select(:id).find_in_batches(batch_size: BATCH_SIZE) do |person_ids|
        Delayed::Job.enqueue(AutomatedNotificationPushJob.new(notification.id, person_ids.pluck(:id)))
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
