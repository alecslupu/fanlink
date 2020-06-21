# frozen_string_literal: true

class InactiveSevenDaysNotificationJob < InactiveNotificationJob
  protected

  def criteria
    :inactive_7days
  end

  def start_time
    Time.zone.now - 8.day
  end

  def end_time
    Time.zone.now - 7.day
  end
end
