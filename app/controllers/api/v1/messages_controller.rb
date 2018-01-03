class Api::V1::MessagesController < ApiController

  load_up_the Room

  #**
  # @api {post} /rooms/id/messages Create a message in a room.
  # @apiName CreateMessage
  # @apiGroup Rooms
  #
  # @apiDescription
  #   The creates a message in a room and posts it to Firebase as appropriate.
  #
  # @apiParam {Object} message
  #   The message object container for the message parameters.
  #
  # @apiParam {String} message.body
  #   The body of the message.
  #
  # @apiParam {Attachment} [message.picture]
  #   NOT YET IMPLEMENTED
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  #*
  def create
    room = Room.find(params[:room_id])
    msg = room.messages.create(message_params.merge(person_id: current_user.id))
    if msg.valid?
      head :ok
    else
      return_the msg
    end
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
  # def index
  #   @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates(current_user) : Room.active.publics
  #   return_the @rooms
  # end

  private

  def message_params
    params.require(:message).permit(:body, :picture)
  end
end
