class Api::V1::BlocksController < ApiController

  #**
  # @api {post} /blocks Block a person.
  # @apiName CreateBlock
  # @apiGroup Blocks
  #
  # @apiDescription
  #   This is used to block a person.
  #
  # @apiParam {Object} block
  #   Block object.
  #
  # @apiParam {Integer} block.blocked_id
  #   Person current user wants to block
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "block": {
  #       "id" : 123, #id of the block
  #       "blocker_id" : 1,
  #       "blocked_id" : 2
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "You already blocked that person, blah blah blah" }
  #*
  def create
    blocked = Person.find(block_params[:blocked_id])
    @block = current_user.block(blocked)
    return_the @block
  end

  #**
  # @api {delete} /blocks/:id Unblock a person.
  # @apiName DeleteBlock
  # @apiGroup Blocks
  #
  # @apiDescription
  #   This is used to unblock a person.
  #
  # @apiParam {Integer} id
  #   id of the underlying block
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 if block not found
  #*
  #*
  def destroy
    @block = current_user.blocks_by.find(params[:id])
    @block.destroy
    head :ok
  end

private

  def block_params
    params.require(:block).permit(:blocked_id)
  end
end
