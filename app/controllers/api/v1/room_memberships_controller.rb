class Api::V1::RoomMembershipsController < ApiController
  #**
  # @api {post} /room/id/room_memberships Add a room member.
  # @apiName CreateRoomMembership
  # @apiGroup Rooms
  #
  # @apiDescription
  #   This adds a person to a private room. On success (person added), just returns 200.
  #
  # @apiParam {Object} person
  #   The person object.
  # @apiParam {Integer} person.id
  #   The id of the person.
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422 Unprocessable - Room not active, current user not room owner, person is unwanted or illigitimate, etc.
  #*
  def create
    room = Room.find(params[:room_id])
    mem = room.room_memberships.create(room_membership_params)
    if mem.valid?
      render body: nil, status: :ok
    else
      puts mem.errors.full_messages
      render json: { errors: mem.errors }, status: :unprocessable_entity
    end
  end

private

  def room_membership_params
    params.require(:room_membership).permit(:person_id)
  end
end
