class Api::V4::PollOptionsController < Api::V3::PollOptionsController 
  def cast_vote
    @vote = PersonPollOption.create(person_id: current_user.id, poll_option_id: params[:poll_option_id])
    if @vote.valid?
      return_the @poll, handler: 'jb', using: :cast_vote
    else
      render_422 @vote.errors
    end
  end
end
