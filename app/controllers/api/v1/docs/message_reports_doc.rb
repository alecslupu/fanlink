class Api::V1::Docs::MessageReportsDoc < Api::V1::Docs::BaseDoc
  #**
  # @api {post} /rooms/:room_id/message_reports Report a message in a public room.
  # @apiName CreateMessageReport
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This reports a message that was posted to a public room.
  #
  # @apiParam (path) {room_id} room_id
  #   Id of the room in which the message was created.
  #
  # @apiParam (body) {Object} message_report
  #   The message report object container.
  #
  # @apiParam (body) {Integer} message_report.message_id
  #   The id of the message being reported.
  #
  # @apiParam (body) {String} [message_report.reason]
  #   The reason given by the user for reporting the message.
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
  # @api {get} /message_reports Get list of messages reports (ADMIN).
  # @apiName GetMessageReports
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of message reports with optional filter.
  #
  # @apiParam (query) {String} [status_filter]
  #   If provided, valid values are "message_hidden", "no_action_needed", and "pending"
  #
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "message_reports": [
  #       {
  #         "id": "1234",
  #         "created_at": "2018-01-08'T'12:13:42'Z",
  #         "updated_at": "2018-01-08'T'12:13:42'Z",
  #         "message_id": 1234,
  #         "poster": "message_username",
  #         "reporter": "message_report_username",
  #         "reason": "I don't like your message",
  #         "status": "pending"
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*

  #**
  # @api {patch} /message_reports/:id Update a Message Report. (Admin)
  # @apiName UpdateMessageReport
  # @apiGroup Messages
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a message report. The only value that can be
  #   changed is the status.
  #
  # @apiParam (path) {id} id
  #   URL parameter. id of the message report you want to update.
  #
  # @apiParam (body) {Object} message_report
  #   The message report object container.
  #
  # @apiParam (body) {status} message_report.status
  #   The new status. Valid statuses are "message_hidden",
  #   "no_action_needed", and "pending".
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Invalid or missing status." }
  #*
  doc_tag name: 'MessageReports', desc: "Message Reports"
  route_base 'api/v1/message_reports'

  components do
    resp :MessageReportsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :message_reports => [
        :message_report => :MessageReport
      ]
    }]
  end

  api :index, '' do
  end

  api :create, 'Report a message in a public room.' do
    desc 'This reports a message that was posted to a public room.'
    query :room_id!
    form! data: {
      :message_report! => {
        :message_id! => { type: Integer,  desc: 'The id of the message being reported.' },
        :reason => { type: String, desc: 'The reason given by the user for reporting the message.'}
      }
    }
  end

  # api :show, '' do

  # end

  api :update, '' do

  end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
