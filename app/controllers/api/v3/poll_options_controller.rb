class Api::V3::PollOptionsController < ApiController
  load_up_the Poll, from: :poll_id
  load_up_the PollOption, from: :id
  # **
  # @api {post} /posts/:post_id/reactions React to a post.
  # @apiName CreatePostReaction
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This reacts to a post.
  #
  # @apiParam (path) {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam (body) {Object} post_reaction
  #   The post reaction object container.
  #
  # @apiParam (body) {String} post_reaction.reaction
  #   The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #   post_reaction {
  #     "id": "1234",
  #     "person_id": 1234,
  #     "post_id": 1234,
  #     "reaction": "1F601"
  #   }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "I don't like your reaction, etc." }
  # *

  def create
    parms = poll_option_params
    @poll_option = PollOption.create(parms)
    @poll_option.poll_id = params[:poll_id]
    if @poll_option.valid?
      @poll_option.save
      return_the @poll_option
    else
      render_422 @poll_option.errors
    end
  end

  # **
  # @api {delete} /posts/:post_id/reactions/:id Delete a reaction to a post.
  # @apiName DeletePostReaction
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This deletes a reaction to a post.
  #
  # @apiParam (path) {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam (path) {Integer} id
  #   The id of the post reaction you are updating
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404
  # *

  def destroy
    if @poll_option.person == current_user
      @poll_option.destroy
      head :ok
    else
      render_not_found
    end
  end

  # **
  # @api {post} /posts/:post_id/reactions/:id Update a reaction to a post.
  # @apiName UpdatePostReaction
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a reaction to a post.
  #
  # @apiParam (path) {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam (path) {Integer} id
  #   The id of the post reaction you are updating
  #
  # @apiParam (body) {Object} post_reaction
  #   The post reaction object container.
  #
  # @apiParam (body) {String} post_reaction.reaction
  #   The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #   post_reaction {
  #     "id": "1234",
  #     "person_id": 1234,
  #     "post_id": 1234,
  #     "reaction": "1F601"
  #   }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "I don't like your new reaction either, etc." }
  # *

  def update
    if params.has_key?(:poll_option)
      if @poll_option.update(poll_option_params)
        return_the @poll_option
      else
        render_422 @poll_option.errors
      end
    else
      render_not_found
    end
  end

  def show
    @poll_option = PostPollOption.find(params[:id])
    if !@poll_option
      render_not_found
    else
      return_the @poll_option
    end
  end

  def index
    @poll_options = paginate @poll.poll_options.order(created_at: :desc)
    return_the @poll_options
  end

  def cast_vote
    @vote = PersonPollOption.create(person_id: current_user.id, poll_option_id: params[:poll_option_id])
    if @vote.valid?
      return_the @poll
    else
      render_422 @vote.errors
    end
  end

private

  def poll_option_params
    params.require(:poll_option).permit(:description, description: {})
  end
end
