class Api::V1::RoomsController < ApiController
  #**
  # @api {post} /rooms Create a private room.
  # @apiName CreateRoom
  # @apiGroup Rooms
  #
  # @apiDescription
  #   The creates a private room and makes it active.
  #
  # @apiParam {Object} room
  #   The room object container for the room parameters.
  #
  # @apiParam {String} room.name
  #   The name of the room. Must be between 3 and 26 characters, inclusive.
  #
  # @apiParam {Attachment} [room.picture]
  #   NOT YET IMPLEMENTED
  #
  # @apiParam {Array} [room.member_ids]
  #   Ids of persons to add as members. You do not need to include the current user, who will be made a member
  #   automatically.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "room":
  #       {
  #         "id": "5016",
  #         "name": "Motley People Only",
  #         "owned": "true", # is current user the owner of room?
  #         "picture_url": "http://host.name/path", #NOT YET IMPLEMENTED
  #       }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "That name is too short, blah blah blah" }
  #*
  def create
    @room = Room.create(room_params.merge(status: :active, created_by_id: current_user.id))
    if @room.valid?
      members_ids = params[:members_ids].is_a?(Array) ? params[:members_ids].map { |m| m.to_i } : []
      members_ids << current_user.id
      members_ids.uniq.each do |i|
        @room.room_memberships.create(person_id: i) if Person.where(id: i).exists?
      end
      @room.reload
    end
    return_the @room
  end

  #**
  # @api {get} /rooms Get a list of rooms.
  # @apiName GetRooms
  # @apiGroup Rooms
  #
  # @apiDescription
  #   This gets a list of active rooms (public or private, as specified by the "private" parameter).
  #
  # @apiParam {Boolean} [private]
  #   Which type of room you want. With true you will get just active private rooms of which the current user is
  #   a member. With false (the default), you will get just all active public rooms.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "rooms": [
  #       {
  #         "id": "5016",
  #         "name": "Motley People Only",
  #         "owned": "false", # is current user the owner of room?
  #         "picture_url": "http://host.name/path", #NOT YET IMPLEMENTED
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def index
    @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates(current_user) : Room.active.publics
    return_the @rooms
  end

private

  def room_params
    params.require(:room).permit(:name, :picture, member_ids: [])
  end
end
