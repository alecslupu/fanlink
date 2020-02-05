class FriendRequestAcceptedPushJob < Struct.new(:relationship_id)
  include Push

  def perform
    relationship = Relationship.find(relationship_id)
    ActsAsTenant.with_tenant(relationship.requested_by.product) do
      Push::FriendRequestAccepted.new.push(relationship)
    end
  end

  def error(job, exception)
    Rails.logger.tagged("[Friend Request Accepted]") { Rails.logger.error exception.inspect }
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
