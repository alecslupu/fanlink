class Api::V4::MessagesController < Api::V3::MessagesController
  def index
    room = Room.find(params[:room_id])
    if !check_access(room)
      render_not_found
    else
      ordering = 'DESC'
      if params[:message_id].present? && (params[:chronologically] == 'after' || params[:chronologically] == 'before')
        if params[:chronologically] == 'after'
          sign = '>'
          ordering = 'ASC'
        else
          sign = '<'
        end

        message = Message.find(params[:message_id])

        if params[:pinned].blank? || params[:pinned].downcase == "all"
          msgs = room.messages.chronological(sign, message.created_at, message.id)
        else
          msgs = room.messages.pinned(params[:pinned]).chronological(sign, message.created_at, message.id)
        end
      else
        msgs = (params[:pinned].blank? || (params[:pinned].downcase == "all")) ? room.messages : room.messages.pinned(params[:pinned])
      end

      @messages = paginate(
                    msgs
                      .visible
                      .unblocked(current_user.blocked_people)
                      .not_reported_by_user(current_user.id)
                      .order(Arel.sql "messages.created_at #{ordering}, messages.id #{ordering} ")
                  )

      clear_count(room) if room.private?
      return_the @messages, handler: tpl_handler
    end
  end

  def list
    @messages = paginate apply_filters
    return_the @messages, handler: tpl_handler
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
        return_the @message, handler: tpl_handler
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
          Rails.logger.tagged("Message Controller") { Rails.logger.debug "Message #{@message.id} created. Pushing message to version: #{@api_version}" } unless Rails.env.production?
          room.update(last_message_timestamp: DateTime.now.to_i) # update the timestamp of the last message received on room
          @message.post(@api_version)
          broadcast(:room_message_created, @message.id, room.product_id)
          if room.private?
            room.increment_message_counters(current_user.id)
            @message.private_message_push
          else
            @message.public_room_message_push
          end
          return_the @message, handler: tpl_handler, using: :show
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
          @message.delete_real_time(@api_version)
        end
        return_the @message, handler: tpl_handler, using: :show
      else
        render_422 @message.errors
      end
    else
      return_the @message, handler: tpl_handler, using: :show
    end
  end

  def stats
    if params.has_key?(:days) && params[:days].respond_to?(:to_i)
      time = params[:days].to_i
    else
      time = 1
    end
    @messages = Message.where("created_at >= ?", time.day.ago).order(Arel.sql "DATE(created_at) ASC").group(Arel.sql "Date(created_at)").count
    return_the @messages, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
