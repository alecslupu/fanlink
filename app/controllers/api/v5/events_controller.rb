class Api::V5::EventsController < Api::V4::EventsController
  def index
    if !check_dates
      render json: { errors: _("Invalid date(s)") }, status: :unprocessable_entity
    else
      start_boundary = (params[:from_date].present?) ? Date.parse(params[:from_date]) : (Time.now - 3.years).beginning_of_day
      end_boundary = (params[:to_date].present?) ? Date.parse(params[:to_date]) : (Time.now + 3.years).end_of_day
      query = (current_user&.role == "super_admin") ? Event : Event.where(deleted: false)
      @events = paginate(query.in_date_range(start_boundary, end_boundary).order(starts_at: :asc))
      return_the @events, handler: tpl_handler
    end
  end

  def show
    @event = Event.find(params[:id])
    return_the @event, handler: tpl_handler
  end
end
