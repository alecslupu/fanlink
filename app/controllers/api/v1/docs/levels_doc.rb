class Api::V1::Docs::LevelsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: "Levels", desc: "Levels"
  route_base "api/v1/levels"

  components do
    resp LevelsArray: ["HTTP/1.1 200 Ok", :json, data: {
      levels: [
        level: :Level
      ]
    }]
  end
  api :index, "Get all available levels." do
    need_auth :SessionCookie
    desc "This gets a list of all levels available to be obtained."
    response_ref 200 => :LevelsArray
  end

  # api :create, '' do

  # end

  # api :show, '' do

  # end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
