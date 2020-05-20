# frozen_string_literal: true
json.cache! ["v3", post_comment_report.updated_at, post_comment_report] do
  json.id post_comment_report.id.to_s
  json.created_at post_comment_report.created_at.to_s
  json.commenter post_comment_report.post_comment.person.username
  json.reporter post_comment_report.person.username
  json.reason post_comment_report.reason
  json.status post_comment_report.status
end
if @req_source == "web"
  json.cache! ["v3", @req_source, post_comment_report.post_comment.updated_at, post_comment_report.post_comment] do
    json.post_comment post_comment_report.post_comment
  end
else
  json.post_comment_id post_comment_report.post_comment_id
end
