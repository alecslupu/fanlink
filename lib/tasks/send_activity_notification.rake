namespace :send_activity_notification do
  desc "Send notification to the users that have been inactive for 48 hours"
  task two_days_inactive: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveTwoDaysNotificationJob.new())
  end

  desc "Send notification to the users that have been inactive for 7 days"
  task seven_days_inactive: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveSevenDaysNotificationJob.new())
  end

  desc "Send notification to the users that have been inactive for 30 days"
  task thirty_days_inactive: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(InactiveThirtyDaysNotificationJob.new())
  end
end
