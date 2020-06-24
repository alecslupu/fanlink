# frozen_string_literal: true

class AutomatedNotificationPushJob < ApplicationJob

  def perform(notification_id, person_ids)
    Push::ScheduledNotification.new.push(notification_id, person_ids)
  end
end
