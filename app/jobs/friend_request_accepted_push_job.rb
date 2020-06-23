# frozen_string_literal: true

class FriendRequestAcceptedPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(relationship_id)
    relationship = Relationship.find(relationship_id)
    ActsAsTenant.with_tenant(relationship.requested_by.product) do
      Push::FriendRequest.new.accepted_push(relationship)
    end
  end
end
