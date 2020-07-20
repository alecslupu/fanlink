# frozen_string_literal: true

json.id room.id
json.name room.name
json.description room.description
json.owned room.created_by_id == current_user.id
json.picture_url AttachmentPresenter.new(room.picture).url
json.public room.public
if room.private?
  json.members room.members, partial: 'api/v1/people/person', as: :person
end
