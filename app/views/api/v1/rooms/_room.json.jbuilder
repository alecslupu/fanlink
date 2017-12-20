json.id room.id
json.name room.name
json.owned room.created_by_id == current_user.id
json.picture_url nil #room.picture_url
