json.id person.id.to_s
json.(person, :username, :name, :picture_url)
json.following current_user && current_user.following?(person)
