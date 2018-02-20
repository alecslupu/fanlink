class Api::V1::MessageReportsController < ApiController

  load_up_the Room, from: :room_id

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

private

  def message_report_params
    params.require(:message_report).permit(:message_id, :reason).merge(person_id: current_user.id)
  end

end