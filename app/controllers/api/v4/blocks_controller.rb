# frozen_string_literal: true

module Api
  module V4
    class BlocksController < Api::V3::BlocksController
      def create
        blocked = Person.find(block_params[:blocked_id])
        @block = current_user.block(blocked)
        if @block.valid?
          Relationship.for_people(current_user, blocked).destroy_all
          current_user.unfollow(blocked)
          blocked.unfollow(current_user)
          return_the @block, handler: tpl_handler
        else
          render_422 @block.errors
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
