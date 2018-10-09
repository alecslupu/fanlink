json.cache! ["v3", post_poll] do
  json.id post_poll.id.to_s
  json.post_id post_poll.post.id.to_s
  json.create_time post_poll.created_at.to_s
  json.description post_poll.description
end