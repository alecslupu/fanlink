class Relationship
  module RealTime
    def friend_request_received_push
      Delayed::Job.enqueue(FriendRequestReceivedPushJob.new(self.id))
    end
  end
end