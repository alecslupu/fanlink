class Api::V1::PostReactionsController < ApiController
  load_up_the Post, from: :post_id
  #**
  # @api {post} /post/:post_id/reactions React to a post.
  # @apiName CreatePostReaction
  # @apiGroup Posts
  #
  # @apiDescription
  #   This reacts to a post.
  #
  # @apiParam {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam {Object} post_reaction
  #   The post reaction object container.
  #
  # @apiParam {String} reaction
  #   The identifier for the reaction.
  #
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "I don't like your reaction, etc." }
  #*
  def create
    parms = post_reaction_params
    if @post.person.try(:product) == current_user.product
      post_reaction = PostReaction.create(parms)
      if post_reaction.valid?
        head :ok
      else
        render_error(post_reaction.errors)
      end
    else
      render_not_found
    end
  end

  private

  def post_reaction_params
    params.require(:post_reaction).permit(:reaction).merge(person_id: current_user.id)
  end
end
