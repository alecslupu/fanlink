class Api::V1::RoomsController < ApiController
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
    @rooms = Room.active_publics
  end
end
