namespace :send_inactive_thirty_days_notification do
  desc "Send notification to the users that have been active in the past 30 days"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(ActiveThirtyDaysNotificationJob.new())
  end
end
