class Api::V3::RecommendedPostsDoc < Api::V3::BaseDoc
  doc_tag name: "RecommendedPosts", desc: "Recommended posts"
  route_base "api/v3/recommended_posts"

  components do
    resp RecommendedPostsArray: ["HTTP/1.1 200 Ok", :json, data: {
      posts: [
        post: :PostJson
      ]
    }]
  end

  api :index, "Get recommended posts." do
    need_auth :SessionCookie
    desc 'This is used to get a list of published posts flagged as "recommended".'
    response_ref 200 => :RecommendedPostsArray
  end

  # api :create, '' do
  #   desc ''
  #   query :, , desc: ''
  #   form! data: {
  #     :! => {
  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
