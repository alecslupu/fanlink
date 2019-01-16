class Api::V4::PollOptionsController < Api::V3::PollOptionsController 
  def cast_vote
    @vote = PersonPollOption.create(person_id: current_user.id, poll_option_id: params[:poll_option_id])
    if current_user.poll_options.where(poll_id: @poll.id)
      render json: {error: "already voted on this poll"}
    elsif @vote.valid?
      return_the @vote, handler: 'jb', using: :cast_vote
    else
      render_422 @vote.errors
    end
  end
end


