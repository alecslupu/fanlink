class Api::V1::RecommendedPostsController < ApiController
  include Rails::Pagination
  #**
  # @api {get} /posts/recommended Get recommended posts.
  # @apiName GetRecommendedPosts
  # @apiGroup Posts
  #
  # @apiDescription
  #   This is used to get a list of published posts flagged as 'recommended'.
  #
  # @apiParam {Integer} [page]
  #   Page number to get. Default is 1.
  #
  # @apiParam {Integer} [per_page]
  #   Page division. Default is 25.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "recommended_posts" {
  #     [ ... post json ...],
  #     ....
  #   }
  #*
  def index
    @posts = paginate Post.for_product(ActsAsTenant.current_tenant).published.where(recommended: true).order(created_at: :desc)
    return_the @posts
  end
end
