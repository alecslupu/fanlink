class Api::V1::Docs::PostCommentReportsDoc < Api::V1::Docs::BaseDoc
  #**
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
  #*

  #**
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
  #*

  #**
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
  #*
  doc_tag name: 'PostCommentReports', desc: "Reported comments on posts"
  route_base 'api/v1/post_comment_reports'

  components do
  end

  # api :index, '' do
  # end

  # api :create, '' do

  # end

  # api :show, '' do

  # end

  # api :update, '' do

  # end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
