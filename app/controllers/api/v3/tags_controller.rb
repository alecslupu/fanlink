class Api::V3::TagsController < Api::V3::BaseController
  # **
  #
  # @api {get} /posts/tags/:tag_name Get Posts by Tag Name
  # @apiName GetPostsByTagName
  # @apiGroup Tags
  # @apiVersion  2.0.0
  #
  #
  # @apiParam  {String} tag_name The tag to return posts for
  #
  # @apiSuccess (200) {Object} Posts description
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiSuccessExample {type} Success-Response:
  # {
  #     property : value
  # }
  #
  #
  # *
  def index
    if params[:tag_name].present?
      @posts = Post.visible.for_tag(params[:tag_name])
      return_the @posts
    else
      render_422 "Parameter tag_name is required."
    end
  end
end
