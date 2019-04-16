class Api::V5::PostReportsController < Api::V4::PostReportsController
  def index
    @post_reports = paginate apply_filters
    return_the @post_reports, handler: tpl_handler
  end
end
