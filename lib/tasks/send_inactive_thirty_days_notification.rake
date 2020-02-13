namespace :send_inactive_thirty_days_notification do
  desc "Send notification to the users that have been inactive for 2 days"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveThirtyDaysNotificationJob.new())
  end
end
