class Api::V5::PollsController < Api::V4::PollsController


  def create
    # parms = poll_params
    @poll = Poll.create(poll_params)
    # if poll_params.has_key?(:poll_type) && params.has_key?(params[:poll][:poll_type]+"_id".to_sym)
    #   @poll.update_attributes(poll_type_id: params[params[:poll][:poll_type]+"_id"])
    #   # @poll.poll_type_id = params[params[:poll][:poll_type]+"_id"]
    # end
    return_the @poll, handler: tpl_handler
  end
  
  def destroy
    if current_user.some_admin?
      @poll.destroy
      head :ok
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:poll)
      if @poll.update_attributes(poll_params)
        return_the @poll, handler: tpl_handler, using: :show
      else
        render_422 @poll.errors
      end
    else
      return_the @poll, handler: tpl_handler, using: :show
    end
  end

  def index
    @polls = paginate(Poll.all.order(created_at: :asc))
    return_the @polls, handler: tpl_handler
  end

  def select
    @polls = Poll.all.map do |poll|
      {
        text: poll.description(@lang),
        value: poll.id
      }
    end
    render json: {polls: @polls}
  end

  protected

  def tpl_handler
    :jb
  end
end
