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
  #   Post picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
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
    @post = Post.create(post_params.merge(person_id: current_user.id))
    if @post.valid?
      if post_post(@post, @post.person.followers)
        @post.published!
      else
        @post.destroy
        @post.errored!
        render_error("Sorry unable to post your post. Please try again later.") && return
      end
    end
    return_the @post
  end

  #**
  # @api {delete} /posts/:id Delete (hide) a single post.
  # @apiName DeletePost
  # @apiGroup Posts
  #
  # @apiDescription
  #   This deletes a single post by marking as deleted. Can only be called by the creator.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 401 Unauthorized, etc.
  #*
  def destroy
    post = Post.visible.find(params[:id])
    if post.person == current_user
      if delete_post(post, post.person.followers)
        post.deleted!
        head :ok
      else
        render_error("Unable to delete the post. Please try again later.")
      end
    else
      render_not_found
    end
  end

  #**
  # @api {get} /posts Get posts for a date range.
  # @apiName GetPosts
  # @apiGroup Posts
  #
  # @apiDescription
  #   This gets a list of posts for a from date, to date, with an optional
  #   limit. Posts are returned newest first, and the limit is applied to that ordering.
  #   Posts included are posts from the current user along with those of the users
  #   the current user is following.
  #
  # @apiParam {String} from_date
  #   From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam {String} to_date
  #   To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam {Integer} [limit]
  #   Limit results to count of limit.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "posts": [
  #       { ....post json..see get post action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*
  def index
    if !check_dates
      render json: { errors: "Missing or invalid date(s)" }, status: :unprocessable_entity
    else
      l = params[:limit].to_i
      l = nil if l == 0
      @posts = Post.visible.following_and_own(current_user).in_date_range(Date.parse(params[:from_date]), Date.parse(params[:to_date])).order(created_at: :desc).limit(l)
      return_the @posts
    end
  end

  #**
  # @api {get} /posts/:id Get a single post.
  # @apiName GetPost
  # @apiGroup Posts
  #
  # @apiDescription
  #   This gets a single post for a post id.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post": [
  #       {
  #         "id": "5016",
  #         "body": "Stupid thing to say",
  #         "create_time": "2018-01-08'T'12:13:42'Z'"
  #         "picture_url": "http://host.name/path",
  #         "person": {...public person json with relationships...}
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def show
    @post = Post.visible.find(params[:id])
    return_the @post
  end

private

  def check_dates
    params[:from_date].present? && DateUtil.valid_date_string?(params[:from_date]) &&
        params[:to_date].present? && DateUtil.valid_date_string?(params[:to_date])
  end

  def post_params
    params.require(:post).permit(:body, :picture)
  end
end
