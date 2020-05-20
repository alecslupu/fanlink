# frozen_string_literal: true
json.cache! ["v3", poll] do
  json.id poll.id.to_s
  json.post_id poll.post.id.to_s
  json.created_at poll.created_at.to_s
  json.description poll.description
  json.start_date poll.start_date
  json.duration poll.duration
  json.poll_status poll.poll_status
end
