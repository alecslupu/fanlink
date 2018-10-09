class Api::V3::PostPollsController < ApiController
  load_up_the Post, from: :post_id
  load_up_the PostPoll, only: %i[ destroy update ]

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
    parms = post_poll_params
    if @post.person.try(:product) == current_user.product
      @post_poll = @post.post_polls.create(parms)
      if @post_poll.valid?
        return_the @post_poll
      else
        render parms
        #render_422 @post_poll.errors
      end
    else
      render_not_found
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
    if @post.person == current_user
      @post_poll.destroy
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
    if params.has_key?(:post_poll)
      if @post.person == current_user
        if @post_poll.update_attributes(post_poll_params)
          return_the @post_poll
        else
          render_422 @post_poll.errors
        end
      else
        render_not_found
      end
    else
      return_the @post_poll
    end
  end

  def index
    @post_polls = paginate @post.post_polls.order(created_at: :desc)
    return_the @post_polls
  end

private

  def post_poll_params
    params.require(:post_poll).permit(:description)
  end
end
