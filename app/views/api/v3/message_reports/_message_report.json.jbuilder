# frozen_string_literal: true

json.cache! ['v3', @req_source, message_report.updated_at, message_report] do
  json.id message_report.id.to_s
  json.created_at message_report.created_at.to_s
  json.updated_at message_report.updated_at.to_s
  json.poster message_report.message.person.username
  json.reporter message_report.person.username
  json.reason message_report.reason
  json.status message_report.status
end
json.message do
  json.id message_report.message.id
  json.room_id message_report.message.room_id
  json.body message_report.message.body
  json.status message_report.message.status
end
if @req_source == 'web'
  json.message do
    json.cache! ['v3', @req_source, message_report.message.updated_at, message_report.message.id] do
      json.id message_report.message.id
      json.room_id message_report.message.room_id
      json.body message_report.message.body
      json.status message_report.message.status
    end
  end
else
  json.message_id message_report.message_id
end
