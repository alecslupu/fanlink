# frozen_string_literal: true

class Api::V3::MessageReportsController < Api::V2::MessageReportsController
  include Messaging

  def update
    if params.has_key?(:message_report)
      parms = message_report_update_params
      @message = @message_report.message
      if MessageReport.valid_status?(parms[:status])
        @message_report.update(parms)
        if parms[:status] == "message_hidden"
          @message.hidden = true
          if @message.save && delete_message(@message, @api_version)
            head :ok
          end
        else
          @message.hidden = false
          @message.status = Message.statuses[:posted]
          @message.save
          head :ok
        end
      else
        render_error(_("Invalid or missing status."))
      end
    else
      render_error(_("Update failed. Missing message_report object."))
    end
  end
end
