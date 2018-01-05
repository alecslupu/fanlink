class Api::V1::MessagesController < ApiController
  include Messaging

  load_up_the Room, from: :room_id

  #**
  # @api {post} /rooms/{room_id}/messages Create a message in a room.
  # @apiName CreateMessage
  # @apiGroup Messages
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
  #     message: { ..message json..see get message action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  #*
  def create
    room = Room.find(params[:room_id])
    if room.active?
      @message = room.messages.create(message_params.merge(person_id: current_user.id))
      if @message.valid?
        post_message(@message)
      end
      return_the @message
    else
      room_inactive
    end
  end

  #**
  # @api {delete} /rooms/{room_id}/messages/id Delete (hide) a single message.
  # @apiName DeleteMessage
  # @apiGroup Messages
  #
  # @apiDescription
  #   This deletes a single message by marking as hidden. Can only be called by the creator.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 401 Unauthorized, etc.
  #*
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
  # @api {get} /rooms/{room_id}/messages Get messages for a date range.
  # @apiName GetMessages
  # @apiGroup Messages
  #
  # @apiDescription
  #   This gets a list of message for a from date, to date, with an optional
  #   limit. Messages are returned newest first, and the limit is applied to that ordering.
  #
  # @apiParam {String} from_date
  #   From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam {String} to_date
  #   To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "messages": [
  #       { ....message json..see get message action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*
  def index
    room = Room.find(params[:room_id])
    if room.active?
      if !check_dates
        render json: { errors: "Missing or invalid date(s)" }, status: :unprocessable_entity
      else
        l = params[:limit].to_i
        l = nil if l == 0
        @messages = Message.visible.for_date_range(room, Date.parse(params[:from_date]), Date.parse(params[:to_date]), l)
        return_the @messages
      end
    else
      room_inactive
    end
  end

  #**
  # @api {get} /rooms/{room_id}/messages/id Get a single message.
  # @apiName GetMessage
  # @apiGroup Messages
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
  #         "created_at": "2018-01-08'T'12:13:42'Z'"
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

  def check_dates
    params[:from_date].present? && DateUtil.valid_date_string?(params[:from_date]) &&
      params[:to_date].present? && DateUtil.valid_date_string?(params[:to_date])
  end

  def message_params
    params.require(:message).permit(:body, :picture)
  end

  def room_inactive
    render json: { errors: "Room is not active" }, status: :unprocessable_entity
  end
end
