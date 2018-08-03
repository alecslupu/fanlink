json.cache! ["v3", message] do
  json.id message.id
  json.create_time message.created_at.to_s
  json.body message.body
  json.picture_url message.picture_url
  json.audio_url message.audio_url
  json.audio_size message.audio_file_size
  json.audio_content_type message.audio_content_type
  json.person do
    json.partial! "api/v3/people/person", locals: { person: message.person, relationships: Relationship.for_people(current_user, message.person) }
  end
  if message.mentions.count > 0
    json.mentions message.mentions, partial: "api/v3/messages/mention", as: :mention
  else
    json.mentions nil
  end
end
