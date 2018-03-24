class Api::V1::MessageReportsController < ApiController
  before_action :admin_only, only: %i[ update ]

  load_up_the Room, from: :room_id
  load_up_the MessageReport, only: :update

  #**
  # @api {post} /rooms/:room_id/message_reports Report a message in a public room.
  # @apiName CreateMessageReport
  # @apiGroup Messages
  #
  # @apiDescription
  #   This reports a message that was posted to a public room.
  #
  # @apiParam {room_id} room_id
  #   Id of the room in which the message was created.
  #
  # @apiParam {Object} message_report
  #   The message report object container.
  #
  # @apiParam {Integer} message_report.message_id
  #   The id of the message being reported.
  #
  # @apiParam {String} [message_report.reason]
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
  def create
    #room id is involved primarily so AaT can do its thing
    parms = message_report_params
    message = Message.find(parms[:message_id])
    if message.room.private?
      render_error("You cannot report a private message")
    else
      message_report = MessageReport.create(message_report_params)
      if message_report.valid?
        head :ok
      else
        render_error(message_report.errors)
      end
    end
  end

  #**
  # @api {patch} /message_reports/:id Update a Message Report.
  # @apiName UpdateMessageReport
  # @apiGroup Messages
  #
  # @apiDescription
  #   This updates a message reports. The only value that can be
  #   changed is the status.
  #
  # @apiParam {id} id
  #   URL parameter. id of the message report you want to update.
  #
  # @apiParam {Object} message_report
  #   The message report object container.
  #
  # @apiParam {status} message_report.status
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
  def update
    parms = message_report_update_params
    if MessageReport.valid_status?(parms[:status])
      @message_report.update(parms)
      head :ok
    else
      render_error("Invalid or missing status.")
    end
  end

private

  def message_report_params
    params.require(:message_report).permit(:message_id, :reason).merge(person_id: current_user.id)
  end

  def message_report_update_params
    params.require(:message_report).permit(:status)
  end
end
