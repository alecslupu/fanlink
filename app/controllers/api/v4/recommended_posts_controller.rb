# frozen_string_literal: true

module Api
  module V4
    class RecommendedPostsController < Api::V3::RecommendedPostsController
      def index
        post_scope = Post.for_product(ActsAsTenant.current_tenant)
                         .visible
                         .where(recommended: true)
                         .order(created_at: :desc)
                         .includes([:poll])
        @posts = params[:page].present? ? paginate(post_scope) : post_scope.first(250)

        @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)

        return_the @posts, handler: tpl_handler
      end

      protected

      def tpl_handler
        'jb'
      end
    end
  end
end
