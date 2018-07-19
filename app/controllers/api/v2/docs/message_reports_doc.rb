class Api::V2::Docs::MessageReportsDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'MessageReports', desc: "Message Reports"
  route_base 'api/v2/message_reports'

  components do
    resp :MessageReportsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :message_reports => [
        :message_report => :MessageReportJson
      ]
    }]

    body! :MessageReportCreateForm, :form, data: {
      :message_report! => {
        :message_id! => { type: Integer,  desc: 'The id of the message being reported.' },
        :reason => { type: String, desc: 'The reason given by the user for reporting the message.'}
      }
    }

    body! :MessageReportUpdateForm, :form, data: {
      :message_report! => {
        :status! => { type: String,  desc: 'The new status. Valid statuses are "message_hidden", "no_action_needed", and "pending".' }
      }
    }
  end

  api :index, 'Get list of messages reports (ADMIN).' do
    need_auth :SessionCookie
    query :status_filter, String, desc: 'If provided, valid values are "message_hidden", "no_action_needed", and "pending"'
    response_ref 200 => :MessageReportsArray
  end

  api :create, 'Report a message in a public room.' do
    need_auth :SessionCookie
    desc 'This reports a message that was posted to a public room.'
    path! :room_id, Integer, desc: 'Id of the room in which the message was created.'
    body_ref :MessageReportCreateForm
    response_ref 200 => :OK
  end

  # api :show, '' do

  # end

  api :update, 'Update a Message Report. (Admin)' do
    need_auth :SessionCookie
    desc 'This updates a message report. The only value that can be changed is the status.'
    body_ref :MessageReportUpdateForm
    response_ref 200 => :OK
  end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
