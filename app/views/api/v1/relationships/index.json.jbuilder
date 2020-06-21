# frozen_string_literal: true

if defined?(@relationships)
  json.relationships @relationships, partial: "api/v1/relationships/relationship", as: :relationship
else
  json.relationships @relationships, partial: "api/v1/relationships/relationship", as: :relationship
end
