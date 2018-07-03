class Api::V1::Docs::BlocksDoc < Api::V1::Docs::BaseDoc
  #**
  # @api {post} /blocks Block a person.
  # @apiName CreateBlock
  # @apiGroup Blocks
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users.
  #
  # @apiParam (body) {Object} block
  #   Block object.
  #
  # @apiParam (body) {Integer} block.blocked_id
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

  #**
  # @api {delete} /blocks/:id Unblock a person.
  # @apiName DeleteBlock
  # @apiGroup Blocks
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to unblock a person.
  #
  # @apiParam (path) {Integer} id
  #   id of the underlying block
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 if block not found
  #*
  doc_tag name: 'Blocks', desc: "Block a person"
  route_base 'api/v1/blocks'

  components do
    resp :BlocksObject => ['HTTP/1.1 200 Ok', :json, data:{
      :block => :Block
    }]
  end

  api :create, 'POST Block a person' do
    desc "This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users."
    form! data: {
      :block! => {
        :blocked_id! => { type: Integer,  desc: 'Internal name of the action type.' },
      }
    }
    response_ref 200 => :BlockObject
  end

  api :destroy, 'POST Unblock a person' do
    response_ref 200 => :Delete
  end
end
