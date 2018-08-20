class Api::V2::RelationshipsDoc < Api::V2::BaseDoc
  doc_tag name: "Relationships", desc: "User's relationships"
  route_base "api/v2/relationships"

  components do
    resp RelationshipsObject: ["HTTP/1.1 200 Ok", :json, data: {
      relationship: :RelationshipJson
    }]
    resp RelationshipsArray: ["HTTP/1.1 200 Ok", :json, data: {
      relationships: [
        relationship: :RelationshipJson
      ]
    }]
  end

  api :index, "Get current relationships of a person." do
    need_auth :SessionCookie
    desc 'This is used to get a list of someone\'s friends. If the person supplied is the logged in user, "requested" status is included for requests TO the current user. Otherwise, only "friended" status is included.'
    path! :person_id, Integer, desc: "Person whose friends to get"
    response_ref 200 => :RelationshipsObject
  end

  api :create, "Send a friend request to a person." do
    need_auth :SessionCookie
    desc "This is used to send a friend request to a person. If there is a block between the people, an error will be returned."
    form! data: {
      relationship!: {
        requested_to_id!: { type: Integer, desc: "Person for whom the request is intended" }
      }
    }
    response_ref 200 => :RelationshipsArray
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :show, "Get a single relationship." do
    need_auth :SessionCookie
    desc "This gets a single relationship for a relationship id. Only available to a participating user."
    response_ref 200 => :RelationshipsObject
  end

  api :update, "Update a relationship." do
    need_auth :SessionCookie
    desc "This is used to accept, deny or unfriend a relationship (friend request)."
    form! data: {
      relationship!: {
        status!: { type: String, desc: '  New status. Valid values are "friended", "denied" or "withdrawn". However each one is only valid in the state and/or from the person that you would expect (e.g. the relationship requester cannot update with "friended").' }
      }
    }
    response_ref 200 => :RelationshipsObject
  end

  api :destroy, "Unfriend a person." do
    need_auth :SessionCookie
    desc "This is used to unfriend a person."
    response_ref 200 => :OK
  end
end
