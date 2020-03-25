class Api::V3::MessagesController < Api::V2::MessagesController
  before_action :admin_only, only: %i[ list update ]

  load_up_the Message, only: %i[ update ]
  load_up_the Room, from: :room_id, except: %i[ update ]


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


  # **
  # @api {post} /rooms/:room_id/messages Create a message in a room.
  # @apiName CreateMessage
  # @apiGroup Messages
  # @apiVersion 2.0.0
  #
  # @apiDescription
  #   This creates a message in a room and posts it to Firebase as appropriate.
  #
  # @apiParam (path) {Number} room_id ID of the room the message belongs to
  # @apiParam (body) {Object} message
  #   The message object container for the message parameters.
  #
  # @apiParam (body) {String} [message.body]
  #   The body of the message.
  #
  # @apiParam (body) {Attachment} [message.picture]
  #   Message picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
  #
  # @apiParam (body) {Attachment} [message.audio]
  #   Message audio, this should be `audio/aac`.
  #
  # @apiParam (body) {Array} [mentions]
  #   Array of mentions each consisting of required person_id (integer), location (integer) and length (integer)
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     message: { ..message json..see get message action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  # *

  def create
    room = Room.find(params[:room_id])
    if room.active?
      if room.public && current_user.chat_banned?
        render json: { errors: "You are banned from chat." }, status: :unprocessable_entity
      else
        @message = room.messages.create(message_params.merge(person_id: current_user.id))
        if @message.valid?
          @message.post
          if room.private?
            room.increment_message_counters(current_user.id)
            @message.private_message_push
          else
            @message.public_room_message_push
          end
          return_the @message
        else
          render_422 @message.errors
        end
      end
    else
      render_422 _("This room is no longer active.")
    end
  end

  # **
  # @api {delete} /rooms/:room_id/messages/:id Delete (hide) a single message.
  # @apiName DeleteMessage
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This deletes a single message by marking as hidden. Can only be called by the creator.
  #
  # @apiParam (path) {Number} room_id Room ID
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 401 Unauthorized, etc.
  # *

  def destroy
    room = Room.find(params[:room_id])
    msg = room.messages.find(params[:id])
    if msg.person == current_user
      msg.hidden = true
      msg.save
      msg.delete_real_time(@api_version)
      head :ok
    else
      head :unauthorized
    end
  end
  # **
  # @api {get} /messages Get a list of messages without regard to room (ADMIN ONLY).
  # @apiName ListMessages
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of messages without regard to room (with possible exception of room filter).
  #
  # @apiParam (query) {Integer} [id_filter]
  #   Full match on Message id.
  #
  # @apiParam (query) {String} [person_filter]
  #   Full or partial match on person username.
  #
  # @apiParam (query) {Integer} [room_id_filter]
  #   Full match on Room id.
  #
  # @apiParam  (query){String} [body_filter]
  #   Full or partial match on message body.
  #
  # @apiParam (query) {Boolean} [reported_filter]
  #   Filter on whether the message has been reported.
  #
  # @apiParam (query) {Integer} [page]
  #   Page number. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   Messages per page. Default is 25.
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
  # *

  def list
    @messages = paginate apply_filters
    return_the @messages
  end

  # **
  # @api {get} /rooms/:room_id/messages/id Get a single message.
  # @apiName GetMessage
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single message for a message id. Only works for messages in private rooms. If the message author
  #   has been blocked by the current user, this will return 404 Not Found.
  #
  # @apiParam (path) {Number} room_id Room ID
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "message":
  #       {
  #         "id": "5016",
  #         "body": "Stupid thing to say",
  #         "created_time": "2018-01-08T12:13:42Z"
  #         "picture_url": "http://host.name/path",
  #         "person": {...public person json with relationships...}
  #       }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  # *

  def show
    room = Room.find(params[:room_id])
    if !check_access(room)
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

  # **
  # @api {patch} /messages/:id Update a message
  # @apiName UpdateMessage
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a message in a room. Only the hidden field can be changed and only by an admin. If the item is
  #   hidden, Firebase will be updated to inform the app that the message has been hidden.
  #
  # @apiParam (path) {Number} id Message ID
  #
  # @apiParam (body) {Object} message
  #   The message object container for the message parameters.
  #
  # @apiParam (body) {Boolean} message.hidden
  #   Whether or not the item is hidden.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     message: { ..message json..see list messages action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401, 404
  # *

  def update
    if params.has_key?(:message)
      if @message.update_attributes(message_update_params)
        if @message.hidden
          @message.delete_real_time(@api_version)
        end
        return_the @message
      else
        render_422 @message.errors
      end
    else
      return_the @message
    end
  end

private

  def apply_filters
    messages = Message.joins(:room).where("rooms.product_id = ? AND rooms.status != ?", ActsAsTenant.current_tenant.id, Room.statuses[:deleted]).order(created_at: :desc)
    params.each do |p, v|
      if p.end_with?("_filter") && Message.respond_to?(p)
        messages = messages.send(p, v)
      end
    end
    messages
  end

  def check_access(room)
    (room.active? && (room.public || room.members.include?(current_user))) || current_user.role == "super_admin"
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
    params.require(:message).permit(:body, :picture, :audio, mentions: %i[ person_id location length ])
  end

  def message_update_params
    params.require(:message).permit(:hidden)
  end
end
