json.id message.id.to_s
json.create_time message.created_at.to_s
json.body message.body
json.picture_url message.picture_id
json.person do
  json.partial! "api/v1/people/person", locals: { person: message.person, relationships: Relationship.for_people(current_user, message.person) }
end
