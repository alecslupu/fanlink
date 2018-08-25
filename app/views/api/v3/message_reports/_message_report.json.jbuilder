json.id message_report.id.to_s
json.created_at message_report.created_at.to_s
json.updated_at message_report.updated_at.to_s
json.message_id message_report.message_id
json.poster message_report.message.person.username
json.reporter message_report.person.username
json.reason message_report.reason
json.status message_report.status

if @req_source == "portal"
  json.cache! ["v3", @req_source, message_report.message.updated_at, message_report.message] do
    json.message message_report.message
  end
else
  json.message_id message_report.message_id
end
