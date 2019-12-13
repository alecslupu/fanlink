class SubscribeToTopicJob < Struct.new(:notification_device_id)
  include Push

  def perform
    notification_device =  NotificationDeviceId.find(notification_device_id)
    ActsAsTenant.with_tenant(notification_device.person.product) do
      # TODO add  topic option
      subscribe_to_topic(notification_device.device_identifier)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
