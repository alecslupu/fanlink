class Api::V5::RoomsController < Api::V4::RoomsController
  def index
    @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates_for_person(current_user) : Room.active.publics.order(order: :desc)
    return_the @rooms, handler: tpl_handler
  end

  def show
    @room = Room.find(params[:id])
    return_the @room, handler: tpl_handler
  end
end
