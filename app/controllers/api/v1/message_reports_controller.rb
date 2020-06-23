# frozen_string_literal: true

module Api
  module V1
    class MessageReportsController < ApiController
      before_action :admin_only, only: %i[index update]

      load_up_the Room, from: :room_id
      load_up_the MessageReport, only: :update

      # **
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
      # *

      def create
        # room id is involved primarily so AaT can do its thing
        parms = message_report_params
        message = Message.find(parms[:message_id])
        if message.room.private?
          render_error(_('You cannot report a private message.'))
        else
          message_report = MessageReport.create(message_report_params)
          if message_report.valid?
            broadcast(:message_report_created, message_report.id, @api_version)
            head :ok
          else
            render_error(message_report.errors)
          end
        end
      end

      # **
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
      # *

      def index
        @message_reports = paginate apply_filters
        return_the @message_reports
      end

      # **
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
      # *

      def update
        parms = message_report_update_params
        if MessageReport.valid_status?(parms[:status])
          @message_report.update(parms)
          head :ok
        else
          render_error('Invalid or missing status.')
        end
      end

      private

      def apply_filters
        message_reports = MessageReport.includes([{message: :room}, :person]).where('rooms.product_id = ?', ActsAsTenant.current_tenant.id).references(:rooms).order(created_at: :desc)
        params.each do |p, v|
          if p.end_with?('_filter') && MessageReport.respond_to?(p)
            message_reports = message_reports.send(p, v)
          end
        end
        message_reports
      end

      def message_report_params
        params.require(:message_report).permit(:message_id, :reason).merge(person_id: current_user.id)
      end

      def message_report_update_params
        params.require(:message_report).permit(:status)
      end
    end
  end
end
