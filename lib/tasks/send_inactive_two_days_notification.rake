namespace :send_inactive_two_days_notification do
  desc "Send notification to the users that have been inactive for 2 days"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveTwoDaysNotificationJob.new())
  end
end
