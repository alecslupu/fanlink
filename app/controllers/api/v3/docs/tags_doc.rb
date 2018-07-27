class Api::V3::Docs::ActivtyTypesDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "Tags", desc: "Tags"
  route_base "api/v3/tags"
  components do
    resp TagArray: ["HTTP/1.1 200 Ok", :json, data: {
      posts: [
        post: :PostJson
      ]
    }]
  end

  api :show, "Find posts by tag" do
    need_auth :SessionCookie
    desc "Returns all posts for the given tag."
    query! :tag_name, String, desc: "The tag to search for."
    response_ref 200 => :TagArray
  end
end
