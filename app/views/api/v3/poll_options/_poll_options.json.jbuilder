json.cache! ["v3", post_poll_options] do
  json.id poll_options.id.to_s
  json.poll_id poll_options.post_poll_id
  json.description poll_options.description
  json.created_at poll_options.created_at.to_s
  json.updated_at poll_options.updated_at.to_s
end