class Api::V5::PollsController < Api::V4::PollsController


  def create
    parms = poll_params
    @poll = Poll.create(parms)
    if poll_params.has_key?(:poll_type) && params.has_key?(params[poll_params[:poll_type]+"id"].to_sym])
      @poll.poll_type_id = params[params[:poll][:poll_type]+"_id"]
    end
    if @poll.valid?
      @poll.save
      return_the @poll, handler: 'jb', using: :show
    else
      render_422 @poll.errors
    end
  end

  def destroy
    if @post.person == current_user
      @poll.destroy
      head :ok
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:poll)
      if @poll.update_attributes(poll_params)
        return_the @poll
      else
        render_422 @poll.errors
      end
    else
      return_the @poll, handler: 'jb', using: :show
    end
  end

  def index
    @polls = paginate(Poll.all.order(created_at: :asc))
    return_the @polls, handler: 'jb'
  end
end
