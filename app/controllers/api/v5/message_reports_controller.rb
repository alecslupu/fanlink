class Api::V5::MessageReportsController < Api::V4::MessageReportsController
  def index
    @message_reports = paginate apply_filters
    return_the @message_reports
  end
end
