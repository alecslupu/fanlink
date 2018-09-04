class Api::V1::BlocksDoc < Api::V1::BaseDoc
  doc_tag name: "Blocks", desc: "Block a person"
  route_base "api/v1/blocks"

  components do
    resp BlocksObject: ["HTTP/1.1 200 Ok", :json, data: {
      block: :Block
    }]
  end

  api :create, "POST Block a person" do
    need_auth :SessionCookie
    form! data: {
      block!: {
        blocked_id!: { type: Integer,  desc: "Internal name of the action type." }
      }
    }
    desc "This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users."
    response_ref 200 => :BlocksObject
  end

  api :destroy, "POST Unblock a person"
end
