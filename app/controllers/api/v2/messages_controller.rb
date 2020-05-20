# frozen_string_literal: true
class Api::V2::MessagesController < Api::V1::MessagesController
  # **
  # @api {get} /rooms/:room_id/messages Get messages.
  # @apiName GetMessages
  # @apiGroup Messages
  # @apiVersion 2.0.0
  #
  # @apiDescription
  #   This gets a list of messages for a page number and a per page parameter.
  #
  # @apiParam (path) {Integer} room_id ID of the room
  #
  # @apiParam (body) {Integer} page
  #
  #   Page number to get.
  #
  # @apiParam (body) {Integer} [per_page]
  #   Number of messages in a page. Default is 25.
  #
  # @apiParam (body) {String} [pinned]
  #   "Yes" to provide only pinned messages, "No" to provide only non-pinned messages. "All" (default) for all
  #   regardless of pinned status.
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
  # *

  def index
    room = Room.find(params[:room_id])
    if !check_access(room)
      render_not_found
    else
      msgs = (params[:pinned].blank? || (params[:pinned].downcase == "all")) ? room.messages : room.messages.pinned(params[:pinned])
      @messages = paginate(msgs.visible.unblocked(current_user.blocked_people).order(created_at: :desc))
      clear_count(room) if room.private?
      return_the @messages
    end
  end
end
