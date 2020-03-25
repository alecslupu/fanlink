class Notification
  module RealTime
    def notify
      Delayed::Job.enqueue(SimpleNotificationPushJob.new(self.id))
    end
  end
end
