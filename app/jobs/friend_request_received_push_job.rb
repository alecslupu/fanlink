class FriendRequestReceivedPushJob < Struct.new(:relationship_id)
  include Push

  def perform
    relationship = Relationship.find(relationship_id)
    ActsAsTenant.with_tenant(relationship.requested_by.product) do
      friend_request_received_push(relationship.requested_by, relationship.requested_to)
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
