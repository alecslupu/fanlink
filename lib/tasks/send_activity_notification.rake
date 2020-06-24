# frozen_string_literal: true

namespace :send_activity_notification do
  desc 'Send notification to the users that have been inactive for 48 hours'
  task two_days_inactive: :environment do
    puts "Sending notification for 48hours inactive at #{Time.zone.now} UTC"

    InactiveTwoDaysNotificationJob.perform_later
  end

  desc 'Send notification to the users that have been inactive for 7 days'
  task seven_days_inactive: :environment do
    puts "Sending notification for 7 days inactive at #{Time.zone.now} UTC"

    InactiveSevenDaysNotificationJob.perform_later
  end

  desc 'Send notification to the users that have been inactive for 30 days'
  task thirty_days_inactive: :environment do
    puts "Sending notification for 30 days inactive at #{Time.zone.now} UTC"

    InactiveThirtyDaysNotificationJob.perform_later
  end
end
