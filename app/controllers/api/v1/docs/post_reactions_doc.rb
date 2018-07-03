class Api::V1::Docs::PostReactionsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'PostReactions', desc: "User reactions to a post"
  route_base 'api/v1/post_reactions'
end
