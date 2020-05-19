# frozen_string_literal: true
class Api::V1::RoomsController < ApiController
  # **
  # @api {post} /rooms Create a private room.
  # @apiName CreateRoom
  # @apiGroup Rooms
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   The creates a private room and makes it active.
  #
  # @apiParam (body) {Object} room
  #   The room object container for the room parameters.
  #
  # @apiParam (body) {String} room.name
  #   The name of the room. Must be between 3 and 26 characters, inclusive.
  #
  # @apiParam (body) {String} [room.description]
  #   The description of the room.
  #
  # @apiParam (body) {Attachment} [room.picture]
  #   Picture for the room.
  #
  # @apiParam (body) {Array} [room.member_ids]
  #   Ids of persons to add as members.  Users who are blocked by or who are blocking the current user will
  #   be silently excluded. You do not need to include the current user, who will be made a member
  #   automatically.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "room":
  #       {
  #         "id": "5016",
  #         "name": "Motley People Only",
  #         "description": "Room description",
  #         "owned": "true", # is current user the owner of room?
  #         "picture_url": "http://host.name/path",
  #         "members": [
  #           {
  #             ....person json...
  #           },....
  #         ]
  #
  #       }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "That name is too short, blah blah blah" }
  # *
  def create
    @room = Room.create(room_params.merge(status: :active, created_by_id: current_user.id).except(:member_ids))
    if @room.valid?
      blocks_with = current_user.blocks_with.map(&:id)
      members_ids = room_params[:member_ids].is_a?(Array) ? room_params[:member_ids].map(&:to_i) : []
      members_ids << current_user.id
      members_ids.uniq.each do |i|
        unless blocks_with.include?(i)
          @room.room_memberships.create(person_id: i) if Person.where(id: i).exists?
        end
      end
      @room.reload
      @room.new_room
    end
    return_the @room
  end

  # **
  # @api {delete} /rooms/:id Delete a private room.
  # @apiName DeleteRoom
  # @apiGroup Rooms
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   The deletes a private room. If it has no messages, it deletes it completely. Otherwise, it just changes the
  #   status to deleted.
  #
  # @apiParam (path) {Integer} id ID of the room to delete
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401, 404
  # *
  def destroy
    @room = Room.find(params[:id])
    if @room.created_by != current_user
      head :unauthorized
    else
      if @room.messages.empty?
        @room.destroy
      else
        @room.deleted!
        @room.delete_me
      end
      head :ok
    end
  end

  # **
  # @api {get} /rooms Get a list of rooms.
  # @apiName GetRooms
  # @apiGroup Rooms
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of active rooms (public or private, as specified by the "private" parameter).
  #
  # @apiParam (body) {Boolean} [private]
  #   Which type of room you want. With true you will get just active private rooms of which the current user is
  #   a member. With false (the default), you will get just all active public rooms.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "rooms": [
  #       {
  #         ....see room json under create above ....
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  # *
  def index
    @rooms = (params["private"].present? && params["private"] == "true") ? Room.active.privates_for_person(current_user) : Room.active.publics
    return_the @rooms
  end

  # **
  # @api {patch} /rooms/:id Update a private room (name).
  # @apiName UpdateRoom
  # @apiGroup Rooms
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   The updates a private room. Only the name can by updated, and only by the owner.
  #
  # @apiParam (path) {Integer} id ID of the room being updated
  # @apiParam (body) {Object} room
  #   The room object container for the room parameters.
  #
  # @apiParam (body) {String} room.name
  #   The name of the room. Must be between 3 and 26 characters, inclusive.
  #
  # @apiParam (body) {Attachment} [room.picture]
  #   NOT YET IMPLEMENTED
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "room":
  #       {
  #         ...see room json for create room...
  #       }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "That name is too short, blah blah blah" }
  # *

  def update
    @room = Room.find(params[:id])
    if @room.created_by != current_user
      head :unauthorized
    else
      @room.update_attribute(:name, room_params[:name])
      return_the @room
    end
  end

private

  def room_params
    params.require(:room).permit(:name, :picture, member_ids: [])
  end
end
