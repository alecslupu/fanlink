# frozen_string_literal: true

class InactiveTwoDaysNotificationJob < InactiveNotificationJob
  protected

  def criteria
    :inactive_48h
  end

  def start_time
    Time.zone.now - 50.hours
  end

  def end_time
    Time.zone.now - 48.hours
  end
end
