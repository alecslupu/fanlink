# frozen_string_literal: true

module Api
  module V1
    class RoomMembershipsController < ApiController
      # **
      # @api {post} /room/:id/room_memberships Add a room member.
      # @apiName CreateRoomMembership
      # @apiGroup Rooms
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This adds a person to a private room. On success (person added), just returns 200.
      #
      # @apiParam (path) {Number} id ID of the room to add the person to
      # @apiParam (body) {Object} person
      #   The person object.
      # @apiParam (body) {Integer} person.id
      #   The id of the person.
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #
      # @apiErrorExample {json} Error-Response:
      #     HTTP/1.1 404 or 422 Unprocessable - Room not active (404), current user not room owner (404), person is unwanted or illigitimate (422), etc.
      # *

      def create
        room = Room.active.privates.find_by(created_by_id: current_user.id, id: params[:room_id].to_i)
        if room
          mem = room.room_memberships.create(room_membership_params)
          if mem.valid?
            render body: nil, status: :ok
          else
            render json: {errors: mem.errors}, status: :unprocessable_entity
          end
        else
          render_not_found
        end
      end

      private

      def room_membership_params
        params.require(:room_membership).permit(:person_id)
      end
    end
  end
end
