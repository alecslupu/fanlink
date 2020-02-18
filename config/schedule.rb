set :environment, "staging"

every 3.hour do
  rake "send_activity_notification:two_days_active"
end

every 3.hour do
  rake "send_activity_notification:two_days_inactive"
end

every :day, at: ["12:00 AM"] do
  rake "send_activity_notification:seven_days_active"
end

every :day, at: ["12:00 AM"] do
  rake "send_activity_notification:seven_days_inactive"
end

every :day, at: ["12:00 AM"] do
  rake "send_activity_notification:thirty_days_active"
end

every :day, at: ["12:00 AM"] do
  rake "send_activity_notification:thirty_days_inactive"
end
