class Api::V3::PollsController < ApiController
  load_up_the Poll, except: %i[ index create ]
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
    parms = poll_params
    @poll = Poll.create(parms)
    @poll.poll_type_id = params[params[:poll][:poll_type] + "_id"]
    if @poll.valid?
      @poll.save
      return_the @poll, handler: tpl_handler, using: :show
    else
      render_422 @poll.errors
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
    if @post.person == current_user || some_admin?
      @poll.destroy
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
    if params.has_key?(:poll)
      if @poll.update(poll_params)
        return_the @poll
      else
        render_422 @poll.errors
      end
    else
      return_the @poll
    end
  end

  def index
    @polls = paginate(Poll.all.order(created_at: :asc))
    return_the @polls
  end

  def list
    @polls = Poll.all
    return_the @polls, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end

    def poll_params
      params.require(:poll).permit(:description, :start_date, :duration, :poll_status, :poll_type, :poll_type_id, description: {})
    end
end
