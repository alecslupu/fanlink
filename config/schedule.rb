set :output, { error: "/home/ubuntu/sites/flapi/current/log/error.log", standard: "/home/ubuntu/sites/flapi/current/log/scheduled.log" }

every 5.minute do
  rake "send_activity_notification:two_days_inactive"
end

every :day, at: ["12:00 PM"] do
  rake "send_activity_notification:seven_days_inactive"
end

every :day, at: ["12:00 PM"] do
  rake "send_activity_notification:thirty_days_inactive"
end
