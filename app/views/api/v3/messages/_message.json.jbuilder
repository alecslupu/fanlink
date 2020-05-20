# frozen_string_literal: true
json.cache! ["v3", message] do
  json.id message.id
  json.room_id message.room_id
  json.create_time message.created_at.to_s
  json.body message.parse_content(3)
  json.picture_url message.picture_url
  json.audio_url message.audio_url
  json.audio_size message.audio_file_size
  json.audio_content_type message.audio_content_type
  json.person do
    json.partial! "api/v3/people/person", locals: { person: message.person, relationships: Relationship.for_people(current_user, message.person) }
  end
  if message.mention_meta.length > 0
    json.mentions message.mention_meta
  else
    json.mentions nil
  end
  json.pinned message.pinned
end
