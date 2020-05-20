# frozen_string_literal: true
class InactiveThirtyDaysNotificationJob < InactiveNotificationJob
  protected

  def criteria
    :inactive_30days
  end

  def start_time
    Time.zone.now - 31.days
  end

  def end_time
    Time.zone.now - 30.days
  end
end
