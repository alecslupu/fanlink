class PostQueueListenerJob < Struct.new(:job_id, :attempts)
  def perform
    @job_id   = job_id
    @attempts = attempts || 0

    the_job_we_want = ->(m) { m["jobId"] == @job_id }
    if (msg = Flaws.extract_from_transcoding_queue(&the_job_we_want))
      Rails.logger.error("\nCalled\n")
      Post.process_et_response(msg)
    elsif (should_keep_trying?)
      Rails.logger.error("\nTrying again\n")
      try_again
    else
      Rails.logger.error("\nGiving up\n")
      give_up
    end
  rescue Aws::SQS::Errors::ServiceError, RuntimeError => e
    # This is only for dev so this is sufficient.
    Rails.logger.error("\nRescued\n")
    Rails.logger.error(e.inspect)
  end

  def queue_name
    :default
  end
  private

    def should_keep_trying?
      @attempts < 30
    end

    def try_again
      Delayed::Job.enqueue(self.class.new(@job_id, @attempts + 1), run_at: 30.seconds.from_now)
    end

    def give_up
      raise "Cannot find #{self.job_id} in SQS and I tried really really hard."
    end
end
