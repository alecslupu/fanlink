class Api::V1::Docs::PostsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Posts', desc: "User/product posts"
  route_base 'api/v1/posts'
end
