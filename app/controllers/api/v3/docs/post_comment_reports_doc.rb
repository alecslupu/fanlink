class Api::V3::Docs::PostCommentReportsDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "PostCommentReports", desc: "Reported comments on posts"
  route_base "api/v3/post_comment_reports"

  components do
    resp PostCommentReportsArray: ["HTTP/1.1 200 Ok", :json, data: {
      post_comment_reports: [
        post_comment_report: :PostCommentReportJson
      ]
    }]

    body! :PostCommentReportCreateForm, :form, data: {
      post_comment_report!: {
        post_comment_id!: { type: Integer, desc: "The id of the post comment being reported." },
        reason: { type: String, desc: "The reason given by the user for reporting the post comment." }
      }
    }

    body! :PostCommentReportUpdateForm, :form, data: {
      post_comment_report!: {
        status!: { type: String, desc: 'The new status. Valid statuses are "pending", "no_action_needed", "comment_hidden"' }
      }
    }
  end

  api :index, "Get list of post comment reports (ADMIN)." do
    need_auth :SessionCookie
    desc "This gets a list of post comment reports with optional filter."
    query :status_filter, String, desc: 'If provided, valid values are "pending", "no_action_needed", and "comment_hidden"'
    response_ref 200 => :PostCommentReportsArray
  end

  api :create, "Report a post comment." do
    need_auth :SessionCookie
    desc "This reports a post comment."
    body_ref :PostCommentReportCreateForm
    response_ref 200 => :OK
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :update, "Update a Post Comment Report (Admin)" do
    need_auth :SessionCookie
    desc "This updates a post comment report. The only value that can be changed is the status."
    body_ref :PostCommentReportUpdateForm
    response_ref 200 => :OK
  end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
