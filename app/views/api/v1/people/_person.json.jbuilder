json.id person.id.to_s
json.(person, :username, :name, :picture_url)
if fol = current_user && current_user.following_for_person(person)
  json.following_id fol.id
else
  json.following_id nil
end
