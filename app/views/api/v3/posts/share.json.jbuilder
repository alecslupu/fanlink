# frozen_string_literal: true
json.post do
  json.id @post.id
  json.body @post.body(@lang)
  json.picture_url @post.picture_url
  json.status @post.status
  json.person do
    json.username @post.person.username
    json.picture_url @post.person.picture_url
  end

end
