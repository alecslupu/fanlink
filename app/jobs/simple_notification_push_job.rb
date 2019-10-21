class SimpleNotificationPushJob < Struct.new(:notification_id)
  include Push

  def perform
    notification = Notification.find(notification_id)
    ActsAsTenant.with_tenant(notification.person.product) do
      current_user = Person.find(notification.person_id)

      if notification.for_followers
        receipents = current_user.followers
      else
        receipents = Person.where.not(id: current_user.id)
      end

      simple_notification_push(notification, current_user, receipents)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
