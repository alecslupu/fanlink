# frozen_string_literal: true
json.id message_report.id.to_s
json.created_at message_report.created_at.to_s
json.updated_at message_report.updated_at.to_s
json.message_id message_report.message_id
json.poster message_report.message.person.username
json.reporter message_report.person.username
json.reason message_report.reason
json.status message_report.status
