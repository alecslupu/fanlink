json.post do
  json.body @post.body(@lang)
  json.picture_url @post.picture.url(:optimal)
  json.person do
    json.username @post.person.username
    json.picture_url @post.person.picture_url
  end

end
