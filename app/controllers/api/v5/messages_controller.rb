class Api::V5::MessagesController < Api::V4::MessagesController
  # TODO remove this as duplicate of  Api::V4::MessagesController#index
  # def index
  #   room = Room.find(params[:room_id])
  #   if !check_access(room)
  #     render_not_found
  #   else
  #     msgs = (params[:pinned].blank? || (params[:pinned].downcase == "all")) ? room.messages : room.messages.pinned(params[:pinned])
  #     @messages = paginate(msgs.visible.unblocked(current_user.blocked_people).order(created_at: :desc))
  #     clear_count(room) if room.private?
  #     return_the @messages, handler: 'jb'
  #   end
  # end

  # TODO remove this as duplicate of  Api::V4::MessagesController#show
  # def show
  #   room = Room.find(params[:room_id])
  #   if !check_access(room)
  #     render_not_found
  #   else
  #     @message = room.messages.unblocked(current_user.blocked_people).find(params[:id])
  #     if @message.hidden
  #       render_not_found
  #     else
  #       return_the @message, handler: 'jb'
  #     end
  #   end
  # end
end
