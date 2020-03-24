class PollJob < Struct.new(:poll_id)
  include RealTimeHelpers

  def perform
    message = Poll.find(poll_id)
    if poll.start + poll.duration < Time.zone.now
      poll.status = disabled
    end
  end

  def queue_name
    :default
  end
end
