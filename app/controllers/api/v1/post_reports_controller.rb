# frozen_string_literal: true

class Api::V1::PostReportsController < ApiController
  before_action :admin_only, only: %i[ index update ]
  load_up_the PostReport, only: :update

  # **
  # @api {post} /post_reports Report a post.
  # @apiName CreatePostReport
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This reports a post that was posted to a feed.
  #
  # @apiParam (body) {Object} post_report
  #   The post report object container.
  #
  # @apiParam (body) {Integer} post_report.post_id
  #   The id of the post being reported.
  #
  # @apiParam (body) {String} [post_report.reason]
  #   The reason given by the user for reporting the post.
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

  # **
  # @api {get} /post_reports Get list of post reports (ADMIN).
  # @apiName GetPostReports
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of post reports with optional filter.
  #
  # @apiParam (query) {Integer} [page]
  #   Page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   Page division. Default is 25.
  #
  # @apiParam (query) {String} [status_filter]
  #   If provided, valid values are "pending", "no_action_needed", and "post_hidden"
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post_reports": [
  #       {
  #         "id": "1234",
  #         "created_at": "2018-01-08T12:13:42Z",
  #         "post_id": 1234,
  #         "poster": "post_username",
  #         "reporter": "post_report_username",
  #         "reason": "I don't like your post",
  #         "status": "pending"
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  # *

  def index
    @post_reports = paginate apply_filters
    return_the @post_reports
  end

  # **
  # @api {patch} /post_reports/:id Update a Post Report.
  # @apiName UpdatePostReport
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a post report. The only value that can be
  #   changed is the status.
  #
  # @apiParam (path) {id} id
  #   URL parameter. id of the post report you want to update.
  #
  # @apiParam (body) {Object} post_report
  #   The post report object container.
  #
  # @apiParam (body) {status} post_report.status
  #   The new status. Valid statuses are "pending", "no_action_needed", "post_hidden"
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
    parms = post_report_update_params
    if PostReport.valid_status?(parms[:status])
      @post_report.update(parms)
      head :ok
    else
      render_error(_("Invalid or missing status."))
    end
  end

private

  def apply_filters
    post_reports = PostReport.for_product(ActsAsTenant.current_tenant).order(created_at: :desc)
    params.each do |p, v|
      if p.end_with?("_filter") && PostReport.respond_to?(p)
        post_reports = post_reports.send(p, v)
      end
    end
    post_reports
  end

  def post_report_params
    params.require(:post_report).permit(:post_id, :reason).merge(person_id: current_user.id)
  end

  def post_report_update_params
    params.require(:post_report).permit(:status)
  end
end
