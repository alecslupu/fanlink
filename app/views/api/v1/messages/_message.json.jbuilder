json.id message.id.to_s
json.body message.body
json.picture_url message.picture_id
json.person message.person, partial: "api/v1/people/person", as: :person
