# frozen_string_literal: true
json.id post_report.id.to_s
json.created_at post_report.created_at.to_s
json.post_id post_report.post.id
json.poster post_report.post.person.username
json.reporter post_report.person.username
json.reason post_report.reason
json.status post_report.status
