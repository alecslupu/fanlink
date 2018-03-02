class Api::V1::PostReactionsController < ApiController
  load_up_the Post, from: :post_id
  load_up_the PostReaction, only: %i[ destroy update ]

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
  # @apiParam {String} post_reaction.reaction
  #   The identifier for the reaction. Accepts stringified hex values between 1F600 and 1F64F, inclusive.
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
  #*
  def create
    parms = post_reaction_params
    if @post.person.try(:product) == current_user.product
      @post_reaction = @post.reactions.create(parms)
      return_the @post_reaction
    else
      render_not_found
    end
  end

  #**
  # @api {delete} /post/:post_id/reactions/:id Delete a reaction to a post.
  # @apiName DeletePostReaction
  # @apiGroup Posts
  #
  # @apiDescription
  #   This deletes a reaction to a post.
  #
  # @apiParam {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam {Integer} id
  #   The id of the post reaction you are updating
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404
  #*
  def destroy
    if @post_reaction.person == current_user
      @post_reaction.destroy
      head :ok
    else
      render_not_found
    end
  end

  #**
  # @api {post} /post/:post_id/reactions/:id Update a reaction to a post.
  # @apiName UpdatePostReaction
  # @apiGroup Posts
  #
  # @apiDescription
  #   This updates a reaction to a post.
  #
  # @apiParam {Integer} post_id
  #   The id of the post to which you are reacting
  #
  # @apiParam {Integer} id
  #   The id of the post reaction you are updating
  #
  # @apiParam {Object} post_reaction
  #   The post reaction object container.
  #
  # @apiParam {String} post_reaction.reaction
  #   The identifier for the reaction. Accepts stringified hex values between 1F600 and 1F64F, inclusive.
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
  #*
  def update
    if @post_reaction.person == current_user
      @post_reaction.update_attributes(post_reaction_params)
      return_the @post_reaction
    else
      render_not_found
    end
  end

private

  def post_reaction_params
    params.require(:post_reaction).permit(:reaction).merge(person_id: current_user.id)
  end
end
