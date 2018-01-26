json.id post.id.to_s
json.create_time post.created_at.to_s
json.body post.body
json.picture_url post.picture_id
json.person do
  json.partial! "api/v1/people/person", locals: { person: post.person, relationships: post.person.relationships }
end
