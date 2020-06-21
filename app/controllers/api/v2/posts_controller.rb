# frozen_string_literal: true

module Api
  module V2
    class PostsController < Api::V1::PostsController
      # **
      # @api {get} /posts Get paginated posts.
      # @apiName GetPosts
      # @apiGroup Posts
      # @apiVersion 2.0.0
      #
      # @apiDescription
      #   This gets a list of posts for a page and an amount per page. Posts are returned newest first.
      #   Posts included are posts from the passed in person or, if none, the current
      #   user along with those of the users the current user is following.
      #
      # @apiParam (body) {Integer} [person_id]
      #   The person whose posts to get. If not supplied, posts from current user plus those from
      #   people the current user is following will be returned.
      #
      # @apiParam (body) {Integer} [page]
      #   Page number to get. Default is 1.
      #
      # @apiParam (body) {Integer} [per_page]
      #   Number of posts in a page. Default is 25.
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #     "posts": [
      #       { ....post json..see get post action ....
      #       },....
      #     ]
      #
      # @apiErrorExample {json} Error-Response:
      #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
      # *

      def index
        if params[:person_id].present?
          pid = params[:person_id].to_i
          person = Person.find_by(id: pid)
          if person
            @posts = paginate(Post.visible.for_person(person).order(created_at: :desc))
          else
            render_error('Cannot find that person.')
            return
          end
        else
          @posts = paginate(Post.visible.following_and_own(current_user).order(created_at: :desc))
        end
        @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
        @posts = @posts.for_tag(params[:tag]) if params[:tag]
        @posts = @posts.for_category(params[:category]) if params[:category]
        return_the @posts
      end
    end
  end
end
