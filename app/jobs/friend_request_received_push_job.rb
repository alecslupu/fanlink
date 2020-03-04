class FriendRequestReceivedPushJob < Struct.new(:relationship_id)
  include Push

  def perform
    relationship = Relationship.find_by_id(relationship_id)
    unless relationship.nil?
      ActsAsTenant.with_tenant(relationship.requested_by.product) do
        friend_request_received_push(relationship.requested_by, relationship.requested_to)
      end
    end
  end

  # ,,, not sure why this doesn't catch.
  def error(job, exception)
    Rails.logger.tagged("[Friend Request Received]") { Rails.logger.error exception.inspect }
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
