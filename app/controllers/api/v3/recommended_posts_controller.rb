# frozen_string_literal: true

class Api::V3::RecommendedPostsController < Api::V2::RecommendedPostsController
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
    if %w[lvconnect nashvilleconnect].include?(ActsAsTenant.current_tenant.internal_name)
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.order(created_at: :desc)
    else
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.where(recommended: true).order(created_at: :desc)
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    return_the @posts
  end
end
