json.id person.id.to_s
json.(person, :email, :username, :name, :picture_url)
if defined?(relationships) && !relationships.empty?
  json.relationships relationships, partial: "api/v1/relationships/relationship", as: :relationship
end
