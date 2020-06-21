# frozen_string_literal: true

class Api::V1::PostCommentReportsController < ApiController
  before_action :admin_only, only: %i[ index update ]
  load_up_the PostCommentReport, only: :update

  # **
  # @api {post} /post_comment_reports Report a post comment.
  # @apiName CreatePostReportComment
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This reports a post comment.
  #
  # @apiParam (body) {Object} post_comment_report
  #   The post report object container.
  #
  # @apiParam (body) {Integer} post_comment_report.post_comment_id
  #   The id of the post comment being reported.
  #
  # @apiParam (body) {String} [post_comment_report.reason]
  #   The reason given by the user for reporting the post comment.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "I don't like your reason, etc." }
  # *

  def create
    parms = post_comment_report_params
    post_comment = PostComment.for_product(ActsAsTenant.current_tenant).find(parms["post_comment_id"])
    if post_comment.product == current_user.product
      post_comment_report = PostCommentReport.create(parms)
      if post_comment_report.valid?
        broadcast(:post_comment_report_created, post_comment_report, @api_version)
        head :ok
      else
        render_error(_(post_comment_report.errors))
      end
    else
      render_not_found
    end
  end

  # **
  # @api {get} /post_comment_reports Get list of post comment reports (ADMIN).
  # @apiName GetPostCommentReports
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of post comment reports with optional filter.
  #
  # @apiParam (query) {Integer} [page]
  #   Page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   Page division. Default is 25.
  #
  # @apiParam (query) {String} [status_filter]
  #   If provided, valid values are "pending", "no_action_needed", and "comment_hidden"
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post_comment_reports": [
  #       {
  #         "id": "1234",
  #         "created_at": "2018-01-08T12:13:42Z",
  #         "post_comment_id": 1234,
  #         "commenter": "post_comment_username",
  #         "reporter": "post_comment_report_username",
  #         "reason": "I don't like your comment",
  #         "status": "pending"
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  # *

  def index
    @post_comment_reports = paginate apply_filters
    return_the @post_comment_reports
  end

  # **
  # @api {patch} /post_comment_reports/:id Update a Post Comment Report (Admin).
  # @apiName UpdatePostCommentReport
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a post comment report. The only value that can be
  #   changed is the status.
  #
  # @apiParam (path) {id} id
  #   URL parameter. id of the post comment report you want to update.
  #
  # @apiParam (body) {Object} post_comment_report
  #   The post report object container.
  #
  # @apiParam (body) {status} post_comment_report.status
  #   The new status. Valid statuses are "pending", "no_action_needed", "comment_hidden"
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Invalid or missing status." }
  # *

  def update
    parms = post_comment_report_update_params
    if PostCommentReport.valid_status?(parms[:status])
      @post_comment_report.update(parms)
      head :ok
    else
      render_error(_("Invalid or missing status."))
    end
  end

private

  def apply_filters
    post_comment_reports = PostCommentReport.for_product(ActsAsTenant.current_tenant).order(created_at: :desc)
    params.each do |p, v|
      if p.end_with?("_filter") && PostCommentReport.respond_to?(p)
        post_comment_reports = post_comment_reports.send(p, v)
      end
    end
    post_comment_reports
  end

  def post_comment_report_params
    params.require(:post_comment_report).permit(:post_comment_id, :reason).merge(person_id: current_user.id)
  end

  def post_comment_report_update_params
    params.require(:post_comment_report).permit(:status)
  end
end
