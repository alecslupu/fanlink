# frozen_string_literal: true

json.cache! ["v3", post_report.updated_at, post_report] do
  json.id post_report.id.to_s
  json.created_at post_report.created_at.to_s
  json.poster post_report.post.person.username
  json.reporter post_report.person.username
  json.reason post_report.reason
  json.status post_report.status
end

if @req_source == "web"
  json.cache! ["v3", @req_source, post_report.post.updated_at, post_report.post] do
    json.post post_report.post
  end
else
  json.post_id post_report.post.id
end
