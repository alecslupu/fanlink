class UnsubscribeToTopicJob < Struct.new(:device_identifier, :device_type, :product_id)
  include Push

  def perform
    product = Product.find(product_id)

    ActsAsTenant.with_tenant(product) do
      # TODO add  topic option
       Push::TopicSubscription.new.unsubscribe_device(device_identifier, device_type)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
