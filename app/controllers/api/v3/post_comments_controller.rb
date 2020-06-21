# frozen_string_literal: true

class Api::V3::PostCommentsController < Api::V2::PostCommentsController
  before_action :load_post, except: %i[list]

  # **
  # @api {post} /posts/:id/comments Create a comment on a post.
  # @apiName CreatePostComment
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This creates a post comment. It is automatically attributed to the logged in user.
  #
  # @apiParam (path) {Integer} id Post ID
  #
  # @apiParam (body) {Object} post_comment
  #   The post_comment object container for the post_comment parameters.
  #
  # @apiParam (body) {String} post_comment.body
  #   The body of the comment.
  #
  # @apiParam (body) {Array} [mentions]
  #   Mentions in the comment.
  #
  # @apiParam (body) {Integer} mention.person_id
  #   The id of the person mentioned.
  #
  # @apiParam (body) {Integer} mention.location
  #   Where the mention text starts in the comment.
  #
  # @apiParam (body) {Integer} mention.length
  #   The length of the mention text.
  #
  # @apiParam (body) {Integer} mention.person_id
  #   The id of the person mentioned.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     post_comment: {
  #       "id": 1234,
  #       "body": "Do you like my body?",
  #       "mentions": [
  #         {
  #           "person_id": 1234,
  #           "location": 1,
  #           "length": 1
  #         },...
  #       ]
  #       "person": { person json }
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  # *

  def create
    if current_user.chat_banned?
      render json: { errors: 'You are banned.' }, status: :unprocessable_entity
    else
      @post_comment = @post.post_comments.create(post_comment_params)
      if @post_comment.valid?
        return_the @post_comment
      else
        render_422 @post_comment.errors
      end
    end
  end

  # **
  # @api {delete} /posts/:post_id/comments/:id Delete a comment on a post.
  # @apiName DeletePostComment
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This deletes a comment on a post. Can be performed by admin or creator of comment.
  #
  # @apiParam (path) {Integer} post_id
  #   The id of the post to which the comment relates
  #
  # @apiParam (path) {Integer} id
  #   The id of the post comment you are deleting
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404
  # *

  def destroy
    comment = @post.comments.find(params[:id])
    if current_user.admin? || comment.person == current_user
      comment.destroy
      head :ok
    else
      render_not_found
    end
  end

  # **
  # @api {get} /posts/:id/comments Get the comments on a post.
  # @apiName GetPostComments
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets all the non-hidden comments on a post with pagination.
  #
  # @apiParam (path) {Integer} id Post ID
  #
  # @apiParam (query) {Integer} [page]
  #   The page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   The pagination division. Default is 25.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post_comments": [
  #       {
  #         ...post comment json..see create action ...
  #       }, ....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  # *

  def index
    @post_comments = paginate @post.comments.visible.order(created_at: :desc)
    return_the @post_comments
  end

  # **
  # @api {get} /post_comments/list Get a list of post comments (ADMIN).
  # @apiName ListPostComments
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of post comments with optional filters and pagination.
  #
  # @apiParam (query) {Integer} [page]
  #   The page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   The pagination division. Default is 25.
  #
  # @apiParam (query) {String} [body_filter]
  #   Full or partial match on comment body.
  #
  # @apiParam (query) {String} [person_filter]
  #   Full or partial match on person username or email.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post_comments": [
  #       {
  #         "id": "123",
  #         "post_id": 3,
  #         "person_id": 123,
  #         "body": "Do you like my body?",
  #         "hidden": false,
  #         "created_at": "2017-12-31T12:13:42Z",
  #         "updated_at": "2017-12-31T12:13:42Z"
  #         "mentions": [
  #           {
  #             "person_id": 1,
  #             "location": 1,
  #             "length": 3
  #           }, ...
  #         ]
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401 Unauthorized
  # *

  def list
    @post_comments = paginate apply_filters
    return_the @post_comments
  end

  private

    def apply_filters
      post_comments = PostComment.where(post_id: Post.for_product(ActsAsTenant.current_tenant)).order(created_at: :desc)
      params.each do |p, v|
        if p.end_with?('_filter') && PostComment.respond_to?(p)
          post_comments = post_comments.send(p, v)
        end
      end
      post_comments
    end

    # fload up doesn't work well at this point with nested tenancy type things like this (the post being only indirectly tenanted).
    def load_post
      @post = Post.for_product(ActsAsTenant.current_tenant).find(params[:post_id])
      if @post.nil?
        render_not_found
      end
    end

    def post_comment_params
      params.require(:post_comment).permit(:body, mentions: %i[person_id location length]).merge(person_id: current_user.id)
    end
end
