namespace :send_inactive_48h_notification do
  desc "Send notification to the users that have been inactive for 48 hours"
  task send_notification: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(Inactive48hNotificationJob.new())
  end
end
