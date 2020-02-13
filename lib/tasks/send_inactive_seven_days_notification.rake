namespace :send_inactive_seven_days_notification do
  desc "Send notification to the users that have been inactive for 7 days"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveSevenDaysNotificationJob.new())
  end
end
