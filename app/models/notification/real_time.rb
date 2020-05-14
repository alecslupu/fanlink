class Notification
  module RealTime
    def notify
      SimpleNotificationPushJob.perform_later(self.id)
    end
  end
end
