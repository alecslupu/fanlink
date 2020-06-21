# frozen_string_literal: true

json.post do
  json.body @post.body
  json.picture_url @post.picture_url
  json.person do
    json.username @post.person.username
    json.picture_url @post.person.picture_url
  end

end
