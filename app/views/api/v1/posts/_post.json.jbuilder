json.id post.id.to_s
json.create_time post.created_at.to_s
json.body post.body
json.picture_url post.picture_url
json.person do
  json.partial! "api/v1/people/person", locals: { person: post.person, relationships: Relationship.for_people(current_user, post.person) }
end
