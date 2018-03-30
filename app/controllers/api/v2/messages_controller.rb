class Api::V2::MessagesController < Api::V1::MessagesController
  #**
  # @api {get} /rooms/{room_id}/messages Get messages for a date range.
  # @apiName GetMessages
  # @apiGroup Messages
  #
  # @apiDescription
  #   This gets a list of messages for a page number and a per page parameter.
  #
  # @apiParam {Integer} page
  #   Page number to get.
  #
  # @apiParam {Integer} per_page
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
    if !check_access(room)
      render_not_found
    else
      @messages = paginate(Message.visible.unblocked(current_user.blocked_people))
      clear_count(room) if room.private?
      return_the @messages
    end
  end

  #**
  # @api {get} /messages Get a list of messages without regard to room (ADMIN ONLY).
  # @apiName GetMessages
  # @apiGroup Messages
  #
  # @apiDescription
  #   This gets a list of messages without regard to room (with possible exception of room filter).
  #
  # @apiParam {Integer} [id_filter]
  #   Full match on Message id.
  #
  # @apiParam {String} [person_filter]
  #   Full or partial match on person username.
  #
  # @apiParam {Integer} [room_id_filter]
  #   Full match on Room id.
  #
  # @apiParam {String} [body_filter]
  #   Full or partial match on message body.
  #
  # @apiParam {Boolean} [reported_filter]
  #   Filter on whether the message has been reported.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "messages": [
  #       {
  #         "id": "123",
  #         "person_id": 123,
  #         "room_id": 123,
  #         "body": "Do you like my body?",
  #         "hidden": false,
  #         "picture_url": "http://example.com/pic.jpg",
  #         "created_at": "2018-01-08'T'12:13:42'Z'",
  #         "updated_at": "2018-01-08'T'12:13:42'Z'"
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401 Unautorized
  #*
  def list
    @messages = apply_filters
    return_the @messages
  end

  #**
  # @api {get} /rooms/{room_id}/messages/id Get a single message.
  # @apiName GetMessage
  # @apiGroup Messages
  #
  # @apiDescription
  #   This gets a single message for a message id. Only works for messages in private rooms. If the message author
  #   has been blocked by the current user, this will return 404 Not Found.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "message":
  #       {
  #         "id": "5016",
  #         "body": "Stupid thing to say",
  #         "created_time": "2018-01-08'T'12:13:42'Z'"
  #         "picture_url": "http://host.name/path",
  #         "person": {...public person json with relationships...}
  #       }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def show
    room = Room.find(params[:room_id])
    if room.public || !check_access(room)
      render_not_found
    else
      @message = room.messages.unblocked(current_user.blocked_people).find(params[:id])
      if @message.hidden
        render_not_found
      else
        return_the @message
      end
    end
  end

  #**
  # @api {patch} /messages/{id} Update a message
  # @apiName UpdateMessage
  # @apiGroup Messages
  #
  # @apiDescription
  #   This updates a message in a room. Only the hidden field can be changed and only by an admin. If the item is
  #   hidden, Firebase will be updated to inform the app that the message has been hidden.
  #
  # @apiParam {Object} message
  #   The message object container for the message parameters.
  #
  # @apiParam {Boolean} message.hidden
  #   Whether or not the item is hidden.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     message: { ..message json..see list messages action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401, 404
  #*
  def update
    @message.update_attributes(message_update_params)
    if @message.hidden
      @message.delete_real_time
    end
    return_the @message
  end

  private

  def apply_filters
    messages = Message.joins(:room).where("rooms.product_id = ?", ActsAsTenant.current_tenant.id).order(created_at: :desc)
    params.each do |p, v|
      if p.end_with?("_filter") && Message.respond_to?(p)
        messages = messages.send(p, v)
      end
    end
    messages
  end

  def check_access(room)
    room.active? && (room.public || room.members.include?(current_user))
  end

  def check_dates
    params[:from_date].present? && DateUtil.valid_date_string?(params[:from_date]) &&
      params[:to_date].present? && DateUtil.valid_date_string?(params[:to_date])
  end

  def clear_count(room)
    membership = room.room_memberships.find_by(person_id: current_user.id)
    if membership
      room.clear_message_counter(membership)
      membership.update_attribute(:message_count, 0)
    end
  end

  def message_params
    params.require(:message).permit(:body, :picture)
  end

  def message_update_params
    params.require(:message).permit(:hidden)
  end

end
