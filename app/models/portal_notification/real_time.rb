class PortalNotification
  module RealTime
    def enqueue_push
      if pending? && self.send_me_at > Time.zone.now
        Delayed::Job.enqueue(PortalNotificationPushJob.new(self.id), run_at: self.send_me_at)
      end
    end

    def update_push
      if pending? && self.send_me_at > Time.zone.now
        get_job.try(:destroy)
        enqueue_push
      end
    end

  private

    # Yes this is too much coupled with DJ's internals, but that is because DJ makes it too hard to do this. Only
    # real solution is to switch to a job framework that does not have this limitation.
    def get_job
      Delayed::Job.find_by("handler like '%portal_notification_id: #{self.id}%'")
    end
  end
end
