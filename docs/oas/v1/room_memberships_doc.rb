class Api::V1::RoomMembershipsDoc < Api::V1::BaseDoc
  doc_tag name: "RoomMemberships", desc: "What rooms a user belongs to."
  route_base "api/v1/room_memberships"

  components do
    # resp :RoomMembershipsObject => ['HTTP/1.1 200 Ok', :json, data:{

    # }]
  end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :create, "Add a room member." do
    need_auth :SessionCookie
    desc "This adds a person to a private room. On success (person added), just returns 200."
    path! :room_id, Integer, desc: "ID of the room to add the person to."
    form! data: {
      person!: {
        id!: { type: Integer, desc: "The id of the person." }
      }
    }
    response_ref 200 => :OK
  end

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
