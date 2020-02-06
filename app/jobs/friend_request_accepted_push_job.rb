class FriendRequestAcceptedPushJob < Struct.new(:relationship_id)
  include Push

  def perform
    relationship = Relationship.find(relationship_id)
    ActsAsTenant.with_tenant(relationship.requested_by.product) do
      Push::FriendRequest.new.accepted_push(relationship)
    end
  end

  def error(job, exception)
    Rails.logger.tagged("[Friend Request Accepted]") { Rails.logger.error exception.inspect }
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
