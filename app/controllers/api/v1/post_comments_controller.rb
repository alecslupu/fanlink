class Api::V1::PostCommentsController < ApiController

  before_action :load_post

  #**
  # @api {post} /posts/:id/comments Create a comment on a post.
  # @apiName CreatePostComment
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This creates a post comment. It is automatically attributed to the logged in user.
  #
  # @apiParam {Object} post_comment
  #   The post_comment object container for the post_comment parameters.
  #
  # @apiParam {String} post_comment.body
  #   The body of the comment.
  #
  # @apiParam {Array} [mentions]
  #   Mentions in the comment.
  #
  # @apiParam {Integer} mention.person_id
  #   The id of the person mentioned.
  #
  # @apiParam {Integer} mention.location
  #   Where the mention text starts in the comment.
  #
  # @apiParam {Integer} mention.length
  #   The length of the mention text.
  #
  # @apiParam {Integer} mention.person_id
  #   The id of the person mentioned.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     post_comment: {
  #       "id": 1234,
  #       "body": "Do you like my body?",
  #       "mentions": [
  #       {
  #         "person_id": 1234,
  #         "location": 1,
  #         "length": 1
  #       }, ....
  #       ]
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  #*
  def create
    @post_comment = @post.post_comments.create(post_comment_params)
    return_the @post_comment
  end

  #**
  # @api {get} /posts/:id/comments Get the comments on a post.
  # @apiName GetPostComments
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets all the non-hidden comments on a post.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post_comments": [
  #       {
  #         ...post comment json..see create action ...
  #       }, ...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*
  def index
    @post_comments = @post.comments.visible.order(created_at: :desc)
    return_the @post_comments
  end

  private

  # fload up doesn't work well at this point with nested tenancy type things like this (the post being only indirectly tenanted).
  def load_post
    @post = Post.for_product(current_user.product).find(params[:post_id])
    if @post.nil?
      render_not_found
    end
  end

  def post_comment_params
    params.require(:post_comment).permit(:body, mentions: %i[ person_id location length ]).merge(person_id: current_user.id)
  end
end