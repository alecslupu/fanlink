class FriendRequestReceivedPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(relationship_id)
    relationship = Relationship.find(relationship_id)
    ActsAsTenant.with_tenant(relationship.requested_by.product) do
      Push::FriendRequest.new.received_push(relationship)
    end
  end
end
