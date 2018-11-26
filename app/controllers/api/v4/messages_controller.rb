class Api::V4::MessagesController < Api::V3::MessagesController
  def index
    room = Room.find(params[:room_id])
    if !check_access(room)
      render_not_found
    else
      msgs = (params[:pinned].blank? || (params[:pinned].downcase == "all")) ? room.messages : room.messages.pinned(params[:pinned])
      @messages = paginate(msgs.visible.unblocked(current_user.blocked_people).order(created_at: :desc))
      clear_count(room) if room.private?
      return_the @messages, handler: 'jb'
    end
  end

  def list
    @messages = paginate apply_filters
    return_the @messages, handler: 'jb'
  end

  def show
    room = Room.find(params[:room_id])
    if !check_access(room)
      render_not_found
    else
      @message = room.messages.unblocked(current_user.blocked_people).find(params[:id])
      if @message.hidden
        render_not_found
      else
        return_the @message, handler: 'jb'
      end
    end
  end

  def create
    room = Room.find(params[:room_id])
    if room.active?
      if room.public && current_user.chat_banned?
        render json: { errors: "You are banned from chat." }, status: :unprocessable_entity
      else
        @message = room.messages.create(message_params.merge(person_id: current_user.id))
        if @message.valid?
          @message.post
          broadcast(:message_created, @message.id, room.product_id)
          if room.private?
            room.increment_message_counters(current_user.id)
            @message.private_message_push
          end
          return_the @message, handler: 'jb', using: :show
        else
          render_422 @message.errors
        end
      end
    else
      render_422 _("This room is no longer active.")
    end
  end

  def update
    if params.has_key?(:message)
      if @message.update_attributes(message_update_params)
        if @message.hidden
          @message.delete_real_time
        end
        return_the @message, handler: 'jb', using: :show
      else
        render_422 @message.errors
      end
    else
      return_the @message, handler: 'jb', using: :show
    end
  end
end
