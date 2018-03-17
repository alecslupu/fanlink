class Api::V1::PostsController < ApiController
  before_action :set_language, only: %i[ index show ]

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
  # @apiParam {String} [post.body]
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
      @post.post
      @post.published!
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
      post.deleted!
      post.delete_real_time
      head :ok
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
  #   limit and person. Posts are returned newest first, and the limit is applied to that ordering.
  #   Posts included are posts from the passed in person or, if none, the current
  #   user along with those of the users the current user is following.
  #
  # @apiParam {Integer} [person_id]
  #   The person whose posts to get. If not supplied, posts from current user plus those from
  #   people the current user is following will be returned.
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
    if !check_dates(true)
      render json: { errors: "Missing or invalid date(s)" }, status: :unprocessable_entity
    else
      l = params[:limit].to_i
      l = nil if l == 0
      if params[:person_id].present?
        pid = params[:person_id].to_i
        person = Person.find_by(id: pid)
        if person
          @posts = Post.visible.for_person(person).in_date_range(Date.parse(params[:from_date]), Date.parse(params[:to_date])).order(created_at: :desc).limit(l)
        else
          render_error("Cannot find that person.") && return
        end
      else
        @posts = Post.visible.following_and_own(current_user).in_date_range(Date.parse(params[:from_date]), Date.parse(params[:to_date])).order(created_at: :desc).limit(l)
      end
      @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
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
  #     "post": {
  #         "id": "5016",
  #         "body": "Stupid thing to say",
  #         "create_time": "2018-01-08'T'12:13:42'Z'"
  #         "picture_url": "http://host.name/path",
  #         "person": {...public person json with relationships...},
  #         "post_reaction_counts": {
  #           "1F600": 1,
  #           "1F601": 3,....
  #         },
  #         "post_reaction": { #post_reaction of current user
  #           ..post_reaction json or null
  #         }
  #
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def show
    @post = Post.for_product(ActsAsTenant.current_tenant).visible.find(params[:id])
    @post_reaction = @post.reactions.find_by(person: current_user)
    return_the @post
  end

private

  def post_params
    params.require(:post).permit(:body, :picture)
  end

  def set_language
    @lang = nil
    lang_header = request.headers["Accept-Language"]
    if lang_header.present?
      if lang_header.length > 2
        lang_header = lang_header[0..1]
      end
      @lang = lang_header if Post::LANGS[lang_header].present?
    end
    @lang = Post::DEFAULT_READ_LANG if @lang.nil?
  end
end
