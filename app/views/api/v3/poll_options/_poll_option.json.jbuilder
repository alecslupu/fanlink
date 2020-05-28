# frozen_string_literal: true
json.cache! ["v3", poll_option] do
  json.id poll_option.id.to_s
  json.id poll_option.poll.id.to_s
  json.create_time poll_option.created_at.to_s
  json.description poll_option.description
end
