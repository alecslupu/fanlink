# frozen_string_literal: true

json.id post_comment_report.id.to_s
json.created_at post_comment_report.created_at.to_s
json.post_comment_id post_comment_report.post_comment_id
json.commenter post_comment_report.post_comment.person.username
json.reporter post_comment_report.person.username
json.reason post_comment_report.reason
json.status post_comment_report.status
