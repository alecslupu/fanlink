class Api::V3::Docs::PostReportsDoc < Api::V3::Docs::BaseDoc
  doc_tag name: 'PostReports', desc: "Posts reported by a user"
  route_base 'api/v3/post_reports'

  components do
    resp :PostReportsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :post_report => :PostReportJson
    }]
    resp :PostReportsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :post_reports => [
        :post_report => :PostReportJson
      ]
    }]

    body! :PostReportsCreateForm, :form, data: {
      :post_report! => {
        :post_id! => { type: Integer, desc: 'The id of the post being reported.' },
        :reason => { type: String, desc: 'The reason given by the user for reporting the post.' }
      }
    }

    body! :PostReportsUpdateForm, :form, data: {
      :post_report! => {
        :status! => { type: String, desc: 'The new status. Valid statuses are "pending", "no_action_needed", "post_hidden"' }
      }
    }
  end

  api :index, 'Get list of post reports (ADMIN).' do
    need_auth :SessionCookie
    desc 'This gets a list of post reports with optional filter.'
    query :status_filter, String, desc: 'If provided, valid values are "pending", "no_action_needed", and "post_hidden"'
    response_ref 200 => :PostReportsArray
  end

  api :create, 'Report a post.' do
    need_auth :SessionCookie
    desc 'This reports a post that was posted to a feed.'
    body_ref :PostReportsCreateForm
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

  api :update, 'Update a Post Report.' do
    need_auth :SessionCookie
    desc 'This updates a post report. The only value that can be changed is the status.'
    body_ref :PostReportsUpdateForm
    response_ref 200 => :OK
  end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end

end
