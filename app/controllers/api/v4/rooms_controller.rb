class Api::V4::RoomsController < Api::V3::RoomsController
  def index
    @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates_for_person(current_user) : Room.active.publics.order(order: :desc)
    return_the @rooms, handler: tpl_handler
  end

  def show
    @room = Room.find(params[:id])
    return_the @room, handler: tpl_handler
  end

  def create
    @room = Room.create(room_params.merge(status: :active, created_by_id: current_user.id).except(:member_ids))
    if @room.valid?
      if !@room.public
        blocks_with = current_user.blocks_with.map { |b| b.id }
        members_ids = room_params[:member_ids].is_a?(Array) ? room_params[:member_ids].map { |m| m.to_i } : []
        members_ids << current_user.id
        members_ids.uniq.each do |i|
          unless blocks_with.include?(i)
            @room.room_memberships.create(person_id: i) if Person.where(id: i).exists?
          end
        end
        @room.reload
        @room.new_room(@api_version)
      end
      return_the @room, handler: tpl_handler, using: :show
    else
      render_422 @room.errors
    end
  end

  def update
    @room = Room.find(params[:id])
    if params.has_key?(:room)
      if some_admin?
        if @room.update_attributes(room_params)
          return_the @room, handler: tpl_handler, using: :show
        else
          render_422(@room.errors)
        end
      elsif @room.created_by != current_user
        head :unauthorized
      else
        if @room.update_attribute(:name, room_params[:name])
          return_the @room, handler: tpl_handler, using: :show
        else
          render_422 @room.errors
        end
      end
    else
      return_the @room, handler: tpl_handler, using: :show
    end
  end

  protected

  def tpl_handler
    :jb
  end
end
