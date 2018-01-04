class Api::V1::MessagesController < ApiController
  include Messaging

  load_up_the Room, {from: :room_id}

  #**
  # @api {post} /rooms/{room_id}/messages Create a message in a room.
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
      post_message(msg)
      head :ok
    else
      return_the msg
    end
  end

  #**
  # @api {delete} /rooms/{room_id}/messages/id Delete (hide) a single message.
  # @apiName DeleteMessage
  # @apiGroup Rooms
  #
  # @apiDescription
  #   This deletes a single message by marking as hidden. Can only be called by the creator.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 401 Unauthorized, etc.
  #
  def destroy
    room = Room.find(params[:room_id])
    msg = room.messages.find(params[:id])
    if msg.person == current_user
      msg.hidden = true
      msg.save
      delete_message(msg)
      head :ok
    else
      head :unauthorized
    end
  end

  #**
  # @api {get} /rooms/{room_id}/messages/id Get a single message.
  # @apiName GetMessage
  # @apiGroup Rooms
  #
  # @apiDescription
  #   This gets a single message for a message id. Only works for messages in private rooms.
  #
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "message": [
  #       {
  #         "id": "5016",
  #         "body": "Stupid thing to say",
  #         "picture_url": "http://host.name/path", #NOT YET IMPLEMENTED,
  #         "person": {...public person json...}
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #
  def show
    room = Room.find(params[:room_id])
    if room.public
      render_not_found
    else
      if room.is_member?(current_user)
        @message = room.messages.find(params[:id])
        if @message.hidden
          render_not_found
        else
          return_the @message
        end
      else
        head :unauthorized
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :picture)
  end
end
