json.post do
  json.body @post.body(@lang)
  json.picture_url @post.picture_url
  json.person do
    json.username @post.person.username
    json.picture_url @post.person.picture_url
  end

end
