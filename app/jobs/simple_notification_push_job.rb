class SimpleNotificationPushJob < Struct.new(:notification_id)
  include Push

  BATCH_SIZE = 50.freeze

  def perform
    notification = Notification.find(notification_id)
    ActsAsTenant.with_tenant(notification.product) do
      current_user = Person.find(notification.person_id)

      if notification.for_followers
        current_user.followers.find_in_batches(batch_size: BATCH_SIZE) do |receipents|
          simple_notification_push(notification, current_user, receipents)
        end
      else
        Person.where.not(id: current_user.id).find_in_batches(batch_size: BATCH_SIZE) do |receipents|
          simple_notification_push(notification, current_user, receipents)
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
