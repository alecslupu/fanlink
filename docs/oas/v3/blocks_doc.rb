class Api::V3::BlocksDoc < Api::V3::BaseDoc
  doc_tag name: "Blocks", desc: "Block a person"
  route_base "api/v3/blocks"

  components do
    resp BlocksObject: ["HTTP/1.1 200 Ok", :json, data: {
      block: :BlockJson
    }]
    body! :BlockCreate, :form, data: {
      block!: {
        blocked_id!: { type: Integer,  desc: "Internal name of the action type." }
      }
    }
  end

  api :create, "POST Block a person" do
    need_auth :SessionCookie
    body_ref :BlockCreate
    desc "This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users."
    response_ref 200 => :BlocksObject
  end

  api :destroy, "POST Unblock a person"
end
