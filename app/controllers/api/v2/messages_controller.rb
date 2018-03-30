class Api::V2::MessagesController < Api::V1::MessagesController
  include Rails::Pagination
  #**
  # @api {get} /rooms/{room_id}/messages Get messages.
  # @apiName GetMessages
  # @apiGroup Messages
  # @apiVersion 2.0.0
  #
  # @apiDescription
  #   This gets a list of messages for a page number and a per page parameter.
  #
  # @apiParam {Integer} page
  #   Page number to get.
  #
  # @apiParam {Integer} per_page
  #   Number of messages in a page.
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
    if !check_access(room)
      render_not_found
    else
      @messages = paginate(Message.visible.unblocked(current_user.blocked_people))
      clear_count(room) if room.private?
      return_the @messages
    end
  end
end
