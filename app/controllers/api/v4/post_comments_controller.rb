# frozen_string_literal: true


module Api
  module V4
    class PostCommentsController < Api::V3::PostCommentsController
      def index
        @post_comments = paginate @post.comments.visible.not_reported.order(created_at: :desc)
        return_the @post_comments, handler: tpl_handler
      end

      def list
        @post_comments = paginate apply_filters
        return_the @post_comments, handler: tpl_handler
      end

      def create
        if current_user.chat_banned?
          render json: {errors: 'You are banned.'}, status: :unprocessable_entity
        else
          @post_comment = @post.post_comments.create(post_comment_params)
          if @post_comment.valid?
            broadcast(:post_comment_created, @post_comment.id, @post.product.id)
            return_the @post_comment, handler: tpl_handler, using: :show
          else
            render_422 @post_comment.errors
          end
        end
      end

      protected

      def tpl_handler
        :jb
      end

      private

      def apply_filters
        post_comments = PostComment.where(post_id: Post.for_product(ActsAsTenant.current_tenant)).visible.order(created_at: :desc)
        params.each do |p, v|
          if p.end_with?('_filter') && PostComment.respond_to?(p)
            post_comments = post_comments.send(p, v)
          end
        end
        post_comments
      end
    end
  end
end
