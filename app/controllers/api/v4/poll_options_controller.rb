# frozen_string_literal: true
class Api::V4::PollOptionsController < Api::V3::PollOptionsController
  def cast_vote
    @vote = PersonPollOption.new(person_id: current_user.id, poll_option_id: params[:poll_option_id])
    if !current_user.poll_options.where(poll_id: @poll.id).blank?
      render json: { error: "already voted on this poll" }
    elsif @vote.valid?
      @vote.save
      return_the @vote, handler: tpl_handler, using: :cast_vote
    else
      render_422 @vote.errors
    end
  end

  def delete_votes
    PersonPollOption.where(poll_option_id: params[:poll_option_id]).destroy_all
    render json: { message: "votes deleted" }
  end

  protected

    def tpl_handler
      :jb
    end
end
