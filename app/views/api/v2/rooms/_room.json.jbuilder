# frozen_string_literal: true
json.id room.id
json.name room.name(@lang)
json.description room.description(@lang)
json.owned room.created_by_id == current_user.id
json.picture_url room.picture_url
json.public room.public
if room.private?
  json.members room.members, partial: "api/v1/people/person", as: :person
end
