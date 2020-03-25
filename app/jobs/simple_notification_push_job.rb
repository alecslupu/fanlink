class SimpleNotificationPushJob < Struct.new(:notification_id)

  BATCH_SIZE = 500.freeze

  def perform
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

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
