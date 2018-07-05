class Api::V1::Docs::PostsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Posts', desc: "User/product posts"
  route_base 'api/v1/posts'

  components do
  end

  # api :index, '' do
  # end

  # api :create, '' do

  # end

  # api :show, '' do

  # end

  # api :update, '' do

  # end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
