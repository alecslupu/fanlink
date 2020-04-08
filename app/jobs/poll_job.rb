class PollJob < ApplicationJob
# TODO remove, does not seems to be used.
  queue_as :default
  include RealTimeHelpers
  def perform(poll_id)
    message = Poll.find(poll_id)
    if poll.start + poll.duration < Time.now
      poll.status = disabled
    end
  end
end
