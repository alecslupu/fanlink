class Api::V1::PostsController < ApiController
  include Messaging

  #**
  # @api {post} /posts Create a post.
  # @apiName CreatePost
  # @apiGroup Posts
  #
  # @apiDescription
  #   This creates a post and puts in on the feed of the author's followers.
  #
  # @apiParam {Object} post
  #   The post object container for the post parameters.
  #
  # @apiParam {String} post.body
  #   The body of the message.
  #
  # @apiParam {Attachment} [post.picture]
  #   NOT YET IMPLEMENTED
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     post: { ..post json..see get post action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  #*
  def create
  end
end