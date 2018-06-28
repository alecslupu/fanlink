class Api::V3::TagsController < Api::V3::BaseController
    #**
    #
    # @api {get} /tags/:tag_name Get Posts by Tag Name
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
    #*
    def show
        @posts = Posts.includes(:tags).where("tags.name = ?", params[:tag_name])
        return_the @posts
    end
end
