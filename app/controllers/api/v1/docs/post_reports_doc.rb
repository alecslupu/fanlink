class Api::V1::Docs::PostReportsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'PostReports', desc: "Posts reported by a user"
  route_base 'api/v1/post_reports'
end
