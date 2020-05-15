class Api::V4::RoomsController < Api::V3::RoomsController
  def index
    @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates_for_person(current_user) : Room.active.publics
    return_the @rooms, handler: tpl_handler
  end

  def show
    @room = Room.find(params[:id])
    return_the @room, handler: tpl_handler
  end

  def create
    @room = Room.new(room_params.merge(status: :active, created_by_id: current_user.id).except(:member_ids))
    room_members = []
    if !@room.public
      blocks_with = current_user.blocks_with.map(&:id)
      members_ids = room_params[:member_ids].is_a?(Array) ? room_params[:member_ids].map(&:to_i) : []
      members_ids << current_user.id

      members_ids.uniq.each do |member_id|
        unless blocks_with.include?(member_id)
          room_members << member_id if Person.where(id: member_id).exists?
        end
      end

      if room_members.count == 1
        render_422
        return
      end
    end
    # the timestamp will reflect the moment of the room's creation
    @room.last_message_timestamp = DateTime.now.to_i
    if @room.save
      room_members.each do |room_member|
        @room.room_memberships.create(person_id: room_member)
      end
      @room.reload
      @room.new_room(@api_version)
      return_the @room, handler: tpl_handler, using: :show
    else
      render_422 @room.errors
    end
  end

  def update
    @room = Room.find(params[:id])
    if params.has_key?(:room)
      if some_admin?
        if @room.update(room_params)
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
