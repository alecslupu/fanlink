class Api::V1::PostCommentReportsController < ApiController
  #**
  # @api {post} /post_comment_reports Report a post comment.
  # @apiName CreatePostReportComment
  # @apiGroup Posts
  #
  # @apiDescription
  #   This reports a post comment.
  #
  # @apiParam {Object} post_comment_report
  #   The post report object container.
  #
  # @apiParam {Integer} post_comment_report.post_comment_id
  #   The id of the post comment being reported.
  #
  # @apiParam {String} [post_comment_report.reason]
  #   The reason given by the user for reporting the post comment.
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
    parms = post_comment_report_params
    post_comment = PostComment.find(parms["post_comment_id"])
    if post_comment.try(:product) == current_user.product
      post_comment_report = PostCommentReport.create(parms)
      if post_comment_report.valid?
        head :ok
      else
        render_error(post_comment_report.errors)
      end
    else
      render_not_found
    end
  end

private

  def post_comment_report_params
    params.require(:post_comment_report).permit(:post_comment_id, :reason).merge(person_id: current_user.id)
  end
end
