class PostQueueListenerJob < ApplicationJob
  queue_as :default

  def perform(job_id, attempts = 0)
    @job_id   = job_id
    @attempts = attempts || 0

    the_job_we_want = ->(m) { m["jobId"] == @job_id }
    if (msg = Flaws.extract_from_transcoding_queue(&the_job_we_want))
      Rails.logger.error("\nCalled\n")
      Post.process_et_response(msg)
    elsif should_keep_trying?
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

  private

    def should_keep_trying?
      @attempts < 30
    end

    def try_again
      PostQueueListenerJob.set(wait_until: 30.seconds.from_now).perform_later(@job_id, @attempts + 1)
    end

    def give_up
      raise "Cannot find #{self.job_id} in SQS and I tried really really hard."
    end
end
