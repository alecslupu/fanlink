class Api::V1::Docs::PostCommentsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'PostComments', desc: "Comments on a post"
  route_base 'api/v1/post_comments'
end
