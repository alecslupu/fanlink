json.cache! ["v3", poll] do
  json.id poll.id.to_s
  json.post_id poll.post.id.to_s
  json.create_time poll.created_at.to_s
  json.description poll.description
end