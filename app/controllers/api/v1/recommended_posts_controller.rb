# frozen_string_literal: true


module Api
  module V1
    class RecommendedPostsController < ApiController
      # **
      # @api {get} /posts/recommended Get recommended posts.
      # @apiName GetRecommendedPosts
      # @apiGroup Posts
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This is used to get a list of published posts flagged as 'recommended'.
      #
      # @apiParam (query) {Integer} [page]
      #   Page number to get. Default is 1.
      #
      # @apiParam (query) {Integer} [per_page]
      #   Page division. Default is 25.
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #   "recommended_posts" {
      #     [ ... post json ...],
      #     ....
      #   }
      # *

      def index
        @posts = paginate Post.for_product(ActsAsTenant.current_tenant).published.where(recommended: true).order(created_at: :desc)
        return_the @posts
      end
    end
  end
end
