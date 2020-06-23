# frozen_string_literal: true

json.id event.id.to_s
json.name event.name
json.description event.description
json.starts_at event.starts_at.to_s
if !event.ends_at.to_s.empty?
  json.ends_at event.ends_at.to_s
else
  json.ends_at nil
end
json.ticket_url event.ticket_url
json.place_identifier event.place_identifier
