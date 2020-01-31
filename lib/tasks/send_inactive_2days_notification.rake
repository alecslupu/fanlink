namespace :send_inactive_2days_notification do
  desc "Send notification to the users that have been inactive for 2 days"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(Inactive2daysNotificationJob.new())
  end
end
