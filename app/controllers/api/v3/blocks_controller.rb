# frozen_string_literal: true

module Api
  module V3
    class BlocksController < Api::V2::BlocksController
      # **
      # @api {post} /blocks Block a person.
      # @apiName CreateBlock
      # @apiGroup Blocks
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This is used to block a person. When a person is blocked, any followings and relationships are immediately
      #   removed between the users.
      #
      # @apiParam (body) {Object} block
      #   Block object.
      #
      # @apiParam (body) {Integer} block.blocked_id
      #   Person current user wants to block
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #     "block": {
      #       "id" : 123, #id of the block
      #       "blocker_id" : 1,
      #       "blocked_id" : 2
      #     }
      #
      # @apiErrorExample {json} Error-Response:
      #     HTTP/1.1 422
      #     "errors" :
      #       { "You already blocked that person, blah blah blah" }
      # *

      def create
        blocked = Person.find(block_params[:blocked_id])
        @block = current_user.block(blocked)
        if @block.valid?
          Relationship.for_people(current_user, blocked).destroy_all
          current_user.unfollow(blocked)
          blocked.unfollow(current_user)
          return_the @block
        else
          render_422 @block.errors
        end
      end
    end
  end
end
