namespace :send_inactive_two_days_notification do
  desc "Send notification to the users that have been active in the past 48 hours"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(ActiveTwoDaysNotificationJob.new())
  end
end
