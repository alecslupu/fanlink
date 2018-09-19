if defined?(@relationships)
  json.relationships @relationships, partial: "api/v4/relationships/relationship", as: :relationship
else
  json.relationships @relationships, partial: "api/v4/relationships/relationship", as: :relationship
end
