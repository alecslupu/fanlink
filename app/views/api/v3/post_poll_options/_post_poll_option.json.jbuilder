json.cache! ["v3", post_poll_option] do
  json.id post_poll_option.id.to_s
  json.post_poll_id post_poll_option.post_poll.id.to_s
  json.create_time post_poll_option.created_at.to_s
  json.description post_poll_option.description
end