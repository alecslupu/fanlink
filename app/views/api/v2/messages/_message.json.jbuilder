# frozen_string_literal: true

json.id message.id.to_s
json.create_time message.created_at.to_s
json.body message.body
json.picture_url AttachmentPresenter.new(message.picture).url
json.audio_url AttachmentPresenter.new(message.audio).url
json.audio_size message.audio_file_size
json.audio_content_type message.audio_content_type
json.person do
  json.partial! 'api/v1/people/person',
                locals: { person: message.person, relationships: Relationship.for_people(current_user, message.person) }
end
if message.mentions.count > 0
  json.mentions message.mentions, partial: 'api/v1/messages/mention', as: :mention
else
  json.mentions nil
end
