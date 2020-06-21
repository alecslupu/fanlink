# frozen_string_literal: true

json.cache! ["v3", mention] do
  json.id mention.id
  json.person_id mention.person_id
  json.location mention.location
  json.length mention.length
end
