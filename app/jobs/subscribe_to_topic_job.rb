class SubscribeToTopicJob < Struct.new(:notification_device_id)
  include Push

  def perform
    notification_device =  NotificationDeviceId.where(id: notification_device_id).first

    ActsAsTenant.with_tenant(notification_device.person.product) do
      # TODO add  topic option
      subscribe_device_to_topic(notification_device)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
