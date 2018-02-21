class Api::V1::PostReportsController < ApiController

  #**
  # @api {post} /post_reports Report a post.
  # @apiName CreatePostReport
  # @apiGroup Posts
  #
  # @apiDescription
  #   This reports a post that was posted to a feed.
  #
  # @apiParam {Object} post_report
  #   The post report object container.
  #
  # @apiParam {Integer} post_report.post_id
  #   The id of the post being reported.
  #
  # @apiParam {String} [post_report.reason]
  #   The reason given by the user for reporting the post.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "I don't like your reason, etc." }
  #*
  def create
    parms = post_report_params
    post = Post.find(parms["post_id"])
    if post.person.try(:product) == current_user.product
      post_report = PostReport.create(parms)
      if post_report.valid?
        head :ok
      else
        render_error(post_report.errors)
      end
    else
      render_not_found
    end
  end

  private

  def post_report_params
    params.require(:post_report).permit(:post_id, :reason).merge(person_id: current_user.id)
  end

end