# frozen_string_literal: true

json.cache! ['v4', post_poll] do
  json.id post_poll.id.to_s
  json.create_time post_poll.created_at.to_s
  json.description post_poll.description
end
