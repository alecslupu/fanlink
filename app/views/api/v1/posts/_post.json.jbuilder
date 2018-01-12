json.id post.id.to_s
json.create_time post.created_at.to_s
json.body post.body
json.picture_url post.picture_id
json.person post.person, partial: "api/v1/people/person", as: :person
