class PostPostJob < Struct.new(:)

  def perform
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
