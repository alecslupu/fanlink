# frozen_string_literal: true

json.id room.id
json.name room.name
json.description room.description
json.owned room.created_by_id == current_user.id
json.picture_url room.picture_url
json.public room.public
json.order room.order
json.last_message_timestamp room.last_message_timestamp
if room.private?
  json.members room.members, partial: 'api/v3/people/person', as: :person
end
if room.pin_from.present?
  json.pin_messages_from do
    json.array!(room.pin_messages) do |pin|
      json.id pin.id
      json.person_id pin.person.id
      json.username pin.person.username
    end
  end
else
  json.pin_messages_from nil
end
