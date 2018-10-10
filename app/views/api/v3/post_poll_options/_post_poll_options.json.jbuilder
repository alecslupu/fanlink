json.cache! ["v3", post_poll_options] do
  json.id post_poll_options.id.to_s
  json.poll_id post_poll_options.post_poll_id
  json.description post_poll_options.description
  json.created_at post_poll_options.created_at.to_s
  json.updated_at post_poll_options.updated_at.to_s
end