json.cache! ["v3", post_polls] do
  json.id post_polls.id.to_s
  json.post_id post_polls.post_id
  json.description post_polls.description
  json.created_at post_polls.created_at.to_s
  json.updated_at post_polls.updated_at.to_s
end