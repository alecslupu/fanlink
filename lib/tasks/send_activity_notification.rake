namespace :send_activity_notification do
  desc "Send notification to the users that have been active in the past 48 hours"
  task two_days_active: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(ActiveTwoDaysNotificationJob.new())
  end

  desc "Send notification to the users that have been active in the past 7 days"
  task seven_days_active: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(ActiveSevenDaysNotificationJob.new())
  end


  desc "Send notification to the users that have been active in the past 30 days"
  task thirty_days_active: :environment do
    puts "Sending notification..."

    Delayed::Job.enqueue(ActiveThirtyDaysNotificationJob.new())
  end

  desc "Send notification to the users that have been inactive for 2 days"
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
