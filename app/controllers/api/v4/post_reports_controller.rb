class Api::V4::PostReportsController < Api::V3::PostReportsController
  def index
    @post_reports = paginate apply_filters
    return_the @post_reports, handler: 'jb'
  end
end
